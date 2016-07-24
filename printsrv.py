# -*- coding: utf-8 -*-
# Written by Janis Putrams for "Biļešu Serviss SIA"
# janis.putrams@gmail.com

import win32ui
import win32gui
import win32con
import win32print
import ConfigParser
import codecs
import imp
import os
import urllib
import urllib2
import urlparse
import inspect
from PIL import Image, ImageWin
from ctypes import *
import string
import time
import wmi
from UrllibProxy import UrllibProxy

# to get file from url for layouts parameter
import posixpath
import urlparse

import email
import email.mime.text
import email.iterators
import email.generator
import email.utils

import esky

import version
from uuid import getnode
import getopt

import sys
sys.coinit_flags = 0 # fixes Win32 exception occurred releasing IUnknown at... ??
import codecs

import logging
import logging.config

import qrcode
import qrcode.image.pil

# ru printer driver
import ecr

# traceback
import traceback

import errno, stat, shutil

EXIT_OK = 0
COULD_NOT_OPEN_PRINTER = 1
COULD_NOT_CREATE_DC = 2
NO_SUCH_FONT_AVAILABLE = 4
UNABLE_TO_CREATE_FONT = 8
CANT_DECODE_AS_UTF8 = 16
NO_IMAGE_BY_THAT_NAME = 32
UNSUPPORTED_IMAGE_FORMAT = 64
COULD_NOT_DOWNLOAD_XML_IMAGE = 128
COULD_NOT_DOWNLOAD_URL_IMAGE = 256
EXCEPTION_IN_2_OF_5 = 512
EXCEPTION_IN_3_OF_9 = 1024
EXCEPTION_IN_CODE128 = 2048
UNKNOWN_TYPE_FOR_SECTION = 4096
NO_SUCH_SECTION = 8192
COULD_NOT_DELETE_PLP = 16384
PLP_FILE_NOT_SPECIFIED = 32768
PRINTER_IS_OFFLINE = 65536
DC_NOT_CREATED = 131072
HDC_NOT_CREATED = 262144
HELP_MESSAGE = 524288
COULD_NOT_DOWNLOAD_URL_LAYOUT = 524288*2

EXIT_STATUS = EXIT_OK

dc = None
hdc = None
proxy = None

class StreamToLogger(object):
   """
   Fake file-like stream object that redirects writes to a logger instance.
   """
   def __init__(self, logger, log_level=logging.INFO):
      self.logger = logger
      self.log_level = log_level
      #self.linebuf = u""

   def write(self, buf):
      for line in buf.rstrip().splitlines():
         self.logger.log(self.log_level, line.rstrip())

#################################################################
def set_exit_status(status):
    global EXIT_STATUS
    EXIT_STATUS = EXIT_STATUS | status

#################################################################
# for code128 used info from http://grandzebu.net/index.php?page=/informatique/codbar-en/code128.htm
#################################################################
def translate_to_code128(chaine):
    def testnum(chaine):
        for i in chaine:
            if not i in string.digits:
                return False
        return True
    Code128=""
    tableB=True
    i=0
    while i<len(chaine):
        if tableB==True:
            #"B==1a"
            if (i<len(chaine)-4):
                if testnum(chaine[i:4]):
                    if i==0:
                        #"START_C"
                        Code128=chr(210) #f
                    else:
                        #"CODE_C"
                        Code128=Code128+chr(204) #f
                    tableB=False
                else:
                    if i==0:
                        #"START_B"
                        Code128=chr(209) #f
                        tableB=True
            else:
                if i==0:
                    #"START_B"
                    Code128=chr(209) #f
                    tableB=True
        if tableB==False:
            #"B==0"
            if testnum(chaine[i:i+2]) and i<=(len(chaine)-2):
                dummy=int(chaine[i:i+2])
                #"TABLE_C processing 2:%s"%chaine[i:i+2]
                if dummy<95:
                    dummy+=32
                else:
                    dummy+=105 #f
                Code128=Code128+chr(dummy)
                i=i+2
            else:
                #"TABLE_C->CODE_B"
                Code128=Code128+chr(205) #f
                tableB=True
        if tableB==True:
            #"B==1b"
            Code128=Code128+chaine[i]
            i=i+1
    for i,dum in enumerate(Code128):
        dummy=ord(dum)
        if dummy<127:
            dummy-=32
        else:
            dummy-=105 #f
        if i==0:
            checksum=dummy
            #"init:%d"%checksum
        checksum=(checksum + i*dummy)
        while checksum>=103: # mod 103
            checksum-=103
        #"iter:%d"%checksum
    if checksum<95:
        checksum+=32
    else:
        checksum+=105 #f
    Code128=Code128+chr(checksum)+chr(211)
    return Code128

#################################################################
def translate_to_3_of_9(code):
    return "*%s*" % code

#################################################################
def translate_to_2_of_5(code):
    length = len(code)
    at = 0
    ret = ""
    while (at < length):
        tmp = int("%s%s" % (code[at], code[at + 1]))
        if (tmp < 94):
            tmp = tmp + 33
        else:
            tmp = tmp + 101
        ret = "%s%s" % (ret, chr(tmp))
        at = at + 2

    return "%s%s%s" % (chr(201), ret, chr(202))

#################################################################
def is_printer_online(printer_name):
    c = wmi.WMI()
    for s in c.Win32_Printer ():
        if(printer_name == s.caption):
            if(s.WorkOffline):
                logger.info("Printer is offline")
                return False
            else:
                logger.info("Printer is online")
                return True

#################################################################
def get_check_printer_msg_text(cfg):
    lang = get_lang(cfg)
    if(lang == "lv"):
        return (u"Pārbaudiet printeri un tad spiediet OK!", u"Pārbaudiet printeri!")
    elif(lang == "ee"):
        return (u"Check printer and click OK when ready!", u"Check printer!")
    elif(lang == "by"):
        return (u"Проверьте принтер и нажмите кнопку OK, когда будете готовы!", u"Проверьте принтер!")
    else:
        return (u"Check printer and click OK when ready!", u"Check printer!")

#################################################################
def start_new_document(cfg, is_first_document = False):
    global dc
    global hdc
    global EXIT_STATUS

    printer = cfg.get("DEFAULT", "printer_name")
    retry_times_left = 3
    # Display message box if printer is not online. Retry 3 times
    while not is_printer_online(printer):
        msg, title = get_check_printer_msg_text(cfg)
        ret = windll.user32.MessageBoxW(0, msg, title, 0x40 | 0x0) #OK only
        retry_times_left -= 1
        if(retry_times_left<=0):
            logger.error("Printer is offline. Exiting")
            set_exit_status(PRINTER_IS_OFFLINE)
            sys.exit(EXIT_STATUS)

    try:
        logger.info("win32print.OpenPrinter(%s) ..."%printer)
        hprinter = win32print.OpenPrinter(printer)
    except:
        logger.error("exception while opening printer");
        set_exit_status(COULD_NOT_OPEN_PRINTER)
        sys.exit(EXIT_STATUS)
    logger.info("win32print.GetPrinter ...")
    devmode = win32print.GetPrinter(hprinter, 2)["pDevMode"]
    logger.info("win32print.EnumJobs ...")
    printjobs = win32print.EnumJobs(hprinter, 0, 999)
    logger.info("Jobs: {0}".format(printjobs))

    # if this is first document then there should be no documents in printer queue
    if(is_first_document):
        retry_times_left = 3
        while (len(printjobs)!=0):
            msg, title = get_check_printer_msg_text(cfg)
            ret = windll.user32.MessageBoxW(0, msg, title, 0x40 | 0x0) #OK only
            retry_times_left -= 1
            if(retry_times_left<=0):
                logger.error("Printer has old jobs in queue. Exiting")
                # set_exit_status(PRINTER_IS_OFFLINE)
                sys.exit(EXIT_STATUS)

    try:
        logger.info("Setting orientation ...")
        devmode.Orientation = int(cfg.get("DEFAULT", "printer_orientation"))
    except:
        pass
    try:
        logger.info("win32gui.CreateDC ...")
        hdc = win32gui.CreateDC("WINSPOOL", printer, devmode)
        logger.info("win32ui.CreateDCFromHandle ...")
        dc = win32ui.CreateDCFromHandle(hdc)
    except:
        logger.error("exception while creating dc")
        set_exit_status(COULD_NOT_CREATE_DC)
        sys.exit(EXIT_STATUS)
    if(dc==None):
        logger.error("dc not created")
        set_exit_status(DC_NOT_CREATED)
        sys.exit(EXIT_STATUS)
    if(hdc==None):
        logger.error("hdc not created")
        set_exit_status(HDC_NOT_CREATED)
        sys.exit(EXIT_STATUS)

    # dc.SetMapMode(win32con.MM_TWIPS)

    logger.info("dc.SetMapMode ...")
    dc.SetMapMode(int(cfg.get("DEFAULT", "map_mode")))
    logger.info("dc.StartDoc ...")
    dc.StartDoc(cfg.get("DEFAULT", "print_document_name"))
    logger.info("dc.StartPage ...")
    dc.StartPage()
    logger.info("win32ui.CreateFont ...");
    font = win32ui.CreateFont({"name": "Arial", "height": 16})
    logger.info("dc.SelectObject ...")
    dc.SelectObject(font)
    logger.info("dc.SelectObject DONE")

#################################################################
def RGB(R, G, B):
    return R + G * 256 + B * 256 * 256

#################################################################
def print_document():
    return # temporary
    dc.EndPage()
    dc.EndDoc()

#################################################################
def set_section_font_indirect(section_cfg,postfix=""):
    global dc
    global hdc
    fonts=[section_cfg["font_name"+postfix]]
    def callback(font, tm, fonttype, fonts):
        if(font.lfFaceName == fonts[0]):
            fonts.append(font)
        return True
    win32gui.EnumFontFamilies(hdc, None, callback,fonts)
    # lf = win32gui.LOGFONT()
    try:
        lf = fonts[1]
    except:
        logger.warning("No such font available:%s" % section_cfg["font_name"+postfix])
        set_exit_status(NO_SUCH_FONT_AVAILABLE)
        lf = win32gui.LOGFONT()
    try:
        lf.lfHeight = int(section_cfg["font_height"+postfix])
    except:
        pass

    try:
        lf.lfWidth = int(section_cfg["font_width"+postfix])
    except:
        pass
    try:
        lf.lfWeight = int(section_cfg["font_weight"+postfix])
    except:
        pass
    try:
        #lf.lfOrientation = int(90)*10
        #lf.lfEscapement = int(90)*10
        lf.lfOrientation = int(section_cfg["font_orientation"+postfix])*10
        lf.lfEscapement = int(section_cfg["font_orientation"+postfix])*10
    except:
        pass
    hFont = win32gui.CreateFontIndirect(lf)
    if not hFont:
        raise StandardError("ERROR: Unable to create font")
    try:
        dc.SetTextColor(RGB(int(section_cfg["font_color_red"+postfix]), int(section_cfg["font_color_green"+postfix]), int(section_cfg["font_color_blue"+postfix])))
    except:
        dc.SetTextColor(RGB(0, 0, 0))
    hFont = win32gui.SelectObject(hdc, hFont)

#################################################################
def set_section_font(section_cfg,postfix=""):
    global dc
    global hdc
    font_params = {}
    font_params["name"] = section_cfg["font_name"+postfix]
    font_params["height"] = int(section_cfg["font_height"+postfix])
    try:
        font_params["width"] = int(section_cfg["font_width"+postfix])
    except:
        pass
    try:
        font_params["weight"] = int(section_cfg["font_weight"+postfix])
    except:
        pass
    font = win32ui.CreateFont(font_params)
    try:
        dc.SetTextColor(RGB(int(section_cfg["font_color_red"+postfix]), int(section_cfg["font_color_green"+postfix]), int(section_cfg["font_color_blue"+postfix])))
    except:
        dc.SetTextColor(RGB(0, 0, 0))
    dc.SelectObject(font)

#################################################################
def print_text_value(section_cfg, value):
    global dc
    global hdc

    try:
        value = value.replace(section_cfg["replace_from"],section_cfg["replace_to"])
    except:
        pass
    try:
        value = unicode( value, "utf-8" )
    except:
        logger.warning("can't decode:%s" % value)
        set_exit_status(CANT_DECODE_AS_UTF8)
    # # value = value.encode("utf-8")
    # value = value.encode("windows-1257")
    # from Tkinter import *
    # from collections import deque
    # root = Tk()
    # w = Label(root, text=value,font = ("freemono","80"))
    # w.pack()
    # root.mainloop()
    # value = value.encode("mbcs")

    # for v in value :
    #     print "%d,"%ord(v)
    # set_section_font(section_cfg,"")
    # windll.gdi32.TextOutW(hdc,int(section_cfg["x"]),int(section_cfg["y"]),value,len(value))
    # value="te"+u"\u2424"+value
    value_w = ""
    value_w1 = ""
    value_w2 = ""
    value_w3 = ""

    value_ww = ""
    value_ww1 = ""
    value_ww2 = ""
    value_ww3 = ""

    value1 = value
    value2 = value
    value3 = value

    try:
        space = value.rfind(u" ",0,int(section_cfg["font_wrap"]))
        logger.info("wrap %d found at:%d"%(int(section_cfg["font_wrap"]),space))
        if(space!=-1):
            value_w = value[space+1:]
            value = value[0:space]
            space = value_w.rfind(u" ",0,int(section_cfg["font_wrap"]))
            if(space!=-1):
                value_ww = value_w[space+1:]
                value_w = value_w[0:space]
    except:
        pass

    try:
        space1 = value1.rfind(u" ",0,int(section_cfg["font_wrap1"]))
        logger.info("wrap %d found at:%d"%(int(section_cfg["font_wrap1"]),space1))
        if(space1!=-1):
            value_w1 = value1[space1+1:]
            value1 = value1[0:space1]
            space1 = value_w1.rfind(u" ",0,int(section_cfg["font_wrap1"]))
            if(space1!=-1):
                value_ww1 = value_w1[space1+1:]
                value_w1 = value_w1[0:space1]
    except:
        pass

    try:
        space2 = value2.rfind(u" ",0,int(section_cfg["font_wrap2"]))
        logger.info(" wrap %d found at:%d" % (int(section_cfg["font_wrap2"]),space2))
        if(space2!=-1):
            value_w2 = value2[space2+1:]
            value2 = value2[0:space2]
            space2 = value_w2.rfind(u" ",0,int(section_cfg["font_wrap2"]))
            if(space2!=-1):
                value_ww2 = value_w2[space2+1:]
                value_w2 = value_w2[0:space2]
    except:
        pass

    try:
        space3 = value3.rfind(u" ",0,int(section_cfg["font_wrap3"]))
        logger.info(" wrap %d found at:%d" % (int(section_cfg["font_wrap3"]),space3))
        if(space3!=-1):
            value_w3 = value3[space3+1:]
            value3 = value3[0:space3]
            space3 = value_w3.rfind(u" ",0,int(section_cfg["font_wrap3"]))
            if(space3!=-1):
                value_ww3 = value_w3[space3+1:]
                value_w3 = value_w3[0:space3]
    except:
        pass

    try:
        set_section_font_indirect(section_cfg,"")
        windll.gdi32.TextOutW(hdc,int(section_cfg["x"]),int(section_cfg["y"]),value,len(value))
        try:
            set_section_font_indirect(section_cfg,"")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x"]),int(section_cfg["y"])+int(section_cfg["font_height"]),value_w,len(value_w))
            set_section_font_indirect(section_cfg,"")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x"]),int(section_cfg["y"])+2*int(section_cfg["font_height"]),value_ww,len(value_ww))
        except:
            pass
        set_section_font_indirect(section_cfg,"1")
        windll.gdi32.TextOutW(hdc,int(section_cfg["x1"]),int(section_cfg["y1"]),value1,len(value1))
        try:
            set_section_font_indirect(section_cfg,"1")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x1"]),int(section_cfg["y1"])+int(section_cfg["font_height1"]),value_w1,len(value_w1))
            set_section_font_indirect(section_cfg,"1")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x1"]),int(section_cfg["y1"])+2*int(section_cfg["font_height1"]),value_ww1,len(value_ww1))
        except:
            pass
        set_section_font_indirect(section_cfg,"2")
        windll.gdi32.TextOutW(hdc,int(section_cfg["x2"]),int(section_cfg["y2"]),value2,len(value2))
        try:
            set_section_font_indirect(section_cfg,"2")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x2"]),int(section_cfg["y2"])+int(section_cfg["font_height2"]),value_w2,len(value_w2))
            set_section_font_indirect(section_cfg,"2")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x2"]),int(section_cfg["y2"])+2*int(section_cfg["font_height2"]),value_ww2,len(value_ww2))
        except:
            pass
        set_section_font_indirect(section_cfg,"3")
        windll.gdi32.TextOutW(hdc,int(section_cfg["x3"]),int(section_cfg["y3"]),value3,len(value3))
        try:
            set_section_font_indirect(section_cfg,"3")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x3"]),int(section_cfg["y3"])+int(section_cfg["font_height3"]),value_w3,len(value_w3))
            set_section_font_indirect(section_cfg,"3")
            windll.gdi32.TextOutW(hdc,int(section_cfg["x3"]),int(section_cfg["y3"])+2*int(section_cfg["font_height3"]),value_ww3,len(value_ww3))
        except:
            pass
    except(KeyError):
        pass
    except:
        raise

#################################################################
def print_image(x, y, value, rotate=0):
    global dc
    global hdc
    try:
        bmp = Image.open(value)
    except:
        logger.error("No image by that name")
        set_exit_status(NO_IMAGE_BY_THAT_NAME)
        return None
    rotate = int(rotate)
    logger.info("rotate=%d" % rotate)
    if(rotate==90):
        bmp = bmp.transpose(Image.ROTATE_90)
    if(rotate==180):
        bmp = bmp.transpose(Image.ROTATE_180)
    if(rotate==270):
        bmp = bmp.transpose(Image.ROTATE_270)

    try:
        dib = ImageWin.Dib(bmp)
    except:
        print "ERROR: Only jpg and bmp are supported"
        set_exit_status(UNSUPPORTED_IMAGE_FORMAT)
        return None
    dib.draw(dc.GetHandleOutput(), (int(x), int(y), int(x) + bmp.size[0], int(y) + bmp.size[1]))

#################################################################
def print_qmatrix(x, y, size, value):
    global dc
    global hdc

    factory = qrcode.image.pil.PilImage

    qr = qrcode.QRCode(
        # version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        # box_size=10,
        # border=4,
    )
    qr.add_data(value)
    qr.make(fit=True)
    im = qr.make_image(image_factory=factory)

    # im = qrcode.make(value, image_factory=factory)
    try:
        dib = ImageWin.Dib(im)
    except:
        print "ERROR: unsupported image format in print_qmatrix"
        set_exit_status(UNSUPPORTED_IMAGE_FORMAT)
        return None
    dib.draw(dc.GetHandleOutput(), (int(x), int(y), int(x) + int(size), int(y) + int(size)))

#################################################################
def print_qmatrix_value(section_cfg, value):
    global dc
    global hdc
    # try:
    print_qmatrix(section_cfg["x"], section_cfg["y"], section_cfg["size"], value)
    # except:
    #     print "exception while printing qmatrix"

#################################################################
def print_image_value(section_cfg, value):
    global dc
    global hdc
    """\n\tThis function prints image specified in ini file\n\tvalues are x position, y position and value which is full path to the jpg/bmp file\n\t"""
    try:
        try:
            print_image(section_cfg["x"], section_cfg["y"], value, section_cfg["orientation"])
        except:
            print_image(section_cfg["x"], section_cfg["y"], value)
        try:
            print_image(section_cfg["x1"], section_cfg["y1"], value, section_cfg["orientation1"])
        except:
            print_image(section_cfg["x1"], section_cfg["y1"], value)

        try:
            print_image(section_cfg["x2"], section_cfg["y2"], value, section_cfg["orientation2"])
        except:
            print_image(section_cfg["x2"], section_cfg["y2"], value)

        try:
            print_image(section_cfg["x3"], section_cfg["y3"], value, section_cfg["orientation3"])
        except:
            print_image(section_cfg["x3"], section_cfg["y3"], value)
    except(KeyError):
        pass
    except:
        raise

#################################################################
def print_image_xml_value(section_cfg, value):
    global dc
    global hdc
    global proxy
    """
    This function prints image specified. if it is not available locally it downloads it from web.
    """
    #local_image_filename = section_cfg["local_image_folder"] + value
    local_image_filename = os.path.join(get_main_dir(), "img", value)

    if not os.path.isfile(local_image_filename):
        try:
            image_url=section_cfg["remote_image_url_folder"] + urllib.quote(value)
            logger.info(" %s" % image_url)

            # this gives error if value has non ascii chars.
            # I guess this is trying to double encode to utf-8
            #image_url = image_url.encode("utf-8")
            #image_url = urllib.quote(image_url)
            #local_image_filename = local_image_filename.encode("utf-8")


            # use proxy class wrap to urllib to download image if proxy is set
            if(proxy == None):
                ret = urllib.urlretrieve(image_url, local_image_filename)
            else:
                urlprx = UrllibProxy(proxy)
                urlprx.urlretrieve(image_url, local_image_filename)

            try:
                print_image(section_cfg["x"], section_cfg["y"], local_image_filename, section_cfg["orientation"])
            except:
                print_image(section_cfg["x"], section_cfg["y"], local_image_filename)
        except urllib2.HTTPError, e:
            print "ERROR: Could not download image:%s. Got error code:%s" % (image_url, e.code)
            set_exit_status(COULD_NOT_DOWNLOAD_XML_IMAGE)
    else:
        try:
            print_image(section_cfg["x"], section_cfg["y"], local_image_filename, section_cfg["orientation"])
        except:
            print_image(section_cfg["x"], section_cfg["y"], local_image_filename)

#################################################################
def print_image_url_value(section_cfg, value):
    global proxy
    """
    This function downloads and prints image specified. First it checks if this file is available localy
    """
    images = value.split(";")
    for image in images:
        if (len(image) != 0):
            image_params = image.split(",")
            if (len(image_params) == 3):
                image_url = image_params[0]
                image_x = image_params[1]
                image_y = image_params[2]
                image_url_parts = urlparse.urlsplit(image_url)
                if (len(image_url_parts) == 5):
                    #local_image_filename = section_cfg["local_image_folder"] + image_url_parts[2].replace("/", "_")
                    local_image_filename = os.path.join(get_main_dir(), "img", image_url_parts[2].replace("/", "_"))

                    if not os.path.isfile(local_image_filename):
                        try:
                            image_url = image_url.encode("utf-8")
                            local_image_filename = local_image_filename.encode("utf-8")
                            # use proxy class wrap to urllib to download image if proxy is set
                            if(proxy == None):
                                ret = urllib.urlretrieve(image_url, local_image_filename)
                            else:
                                urlprx = UrllibProxy(proxy)
                                ret = urlprx.urlretrieve(image_url, local_image_filename)
                            print_image(image_x, image_y, local_image_filename)
                        except urllib2.HTTPError, e:
                            print "ERROR: Could not download image:%s. Got error code:%s" % (image_url, e.code)
                            set_exit_status(COULD_NOT_DOWNLOAD_URL_IMAGE)
                    else:
                        print_image(image_x, image_y, local_image_filename)

#################################################################
def print_bar_2_of_5_value(section_cfg, value):
    global dc
    global hdc
    try:
        set_section_font_indirect(section_cfg,"")
        dc.TextOut(int(section_cfg["x"]), int(section_cfg["y"]), translate_to_2_of_5(value))
        set_section_font_indirect(section_cfg,"1")
        dc.TextOut(int(section_cfg["x1"]), int(section_cfg["y1"]), translate_to_2_of_5(value))
        set_section_font_indirect(section_cfg,"2")
        dc.TextOut(int(section_cfg["x2"]), int(section_cfg["y2"]), translate_to_2_of_5(value))
        set_section_font_indirect(section_cfg,"3")
        dc.TextOut(int(section_cfg["x3"]), int(section_cfg["y3"]), translate_to_2_of_5(value))
    except(KeyError):
        pass
    except:
        set_exit_status(EXCEPTION_IN_2_OF_5)
        raise

#################################################################
def print_bar_3_of_9_value(section_cfg, value):
    global dc
    global hdc
    try:
        set_section_font_indirect(section_cfg,"")
        dc.TextOut(int(section_cfg["x"]), int(section_cfg["y"]), translate_to_3_of_9(value))
        set_section_font_indirect(section_cfg,"1")
        dc.TextOut(int(section_cfg["x1"]), int(section_cfg["y1"]), translate_to_3_of_9(value))
        set_section_font_indirect(section_cfg,"2")
        dc.TextOut(int(section_cfg["x2"]), int(section_cfg["y2"]), translate_to_3_of_9(value))
        set_section_font_indirect(section_cfg,"3")
        dc.TextOut(int(section_cfg["x3"]), int(section_cfg["y3"]), translate_to_3_of_9(value))
    except(KeyError):
        pass
    except:
        set_exit_status(EXCEPTION_IN_3_OF_9)
        raise

#################################################################
def print_code128_value(section_cfg, value):
    global dc
    global hdc
    try:
        set_section_font_indirect(section_cfg,"")
        dc.TextOut(int(section_cfg["x"]), int(section_cfg["y"]), translate_to_code128(value))
        set_section_font_indirect(section_cfg,"1")
        dc.TextOut(int(section_cfg["x1"]), int(section_cfg["y1"]), translate_to_code128(value))
        set_section_font_indirect(section_cfg,"2")
        dc.TextOut(int(section_cfg["x2"]), int(section_cfg["y2"]), translate_to_code128(value))
        set_section_font_indirect(section_cfg,"3")
        dc.TextOut(int(section_cfg["x3"]), int(section_cfg["y3"]), translate_to_code128(value))
    except(KeyError):
        pass
    except:
        set_exit_status(EXCEPTION_IN_CODE128)
        raise

#################################################################
def font_tests():
    global dc
    global hdc
    arr = {}
    arr["x"] = 300
    arr["y"] = -300
    arr["font_name"] = "Arial"
    arr["font_height"] = 32
    text = "jhg\xe2"
    #print type(text)
    #print type(text)
    #print type(text)
    set_section_font(arr,"")
    dc.TextOut(int(arr["x"]), int(arr["y"]), text)

#################################################################
def print_static_text_value(cfg):
    for section in cfg.sections():
        try:
            if (cfg.get(section, "type") == "static_text"):
                text_value = cfg.get(section, "value")
                text_value = text_value.decode("windows-1257")
                text_value = text_value.encode("UTF-8")
                print_text_value(dict(cfg.items(section)), text_value)
            elif (cfg.get(section, "type") == "image"):
                print_image_value(dict(cfg.items(section)), cfg.get(section, "value"))
        except:
            logger.info("no section type")
            pass

#################################################################
def read_plp_file(cfg, plp_filename, skip_file_delete):
    global dc
    global hdc
    global proxy

    document_open = 0
    infile = open(plp_filename, "rb")
    param_dict = {}
    while infile:
        line = infile.readline()
        if line.startswith(codecs.BOM_UTF8):
            line = line[3:]

        if (len(line) == 0):
            break
        line = line.strip()
        value = line.split("=")
        #################################################################
        # Start new document
        #################################################################
        if (line[:6] == "BEGIN "):
            begin_section_name = line
            # attempt to check if there is a layouts definition
            file_read_pos = infile.tell()
            line = infile.readline()
            params = line.split("=")
            if(len(params)==2):
                key = params[0].strip()
                value = params[1].strip()
                if(key == "layout"):
                    # is this going to work?
                    if(cfg.has_option("DEFAULT", "layout")):
                        if(cfg.get("DEFAULT", "layout")=="none"):
                            layout_cfg = cfg
                        else:
                            layout_cfg = get_layout_cfg(value)
                    else:
                        layout_cfg = get_layout_cfg(value)
                else:
                    infile.seek(file_read_pos) # undo up one line. it was not layout directive
                    layout_cfg = cfg # use original ini file for cfg.
            else:
                infile.seek(file_read_pos) # undo up one line. it was not layout directive
                layout_cfg = cfg # use original ini file for cfg.

            logger.info("start new document")
            printer_cfg = cfg

            # we check for old jobs in printer queue when starting first document
            if(begin_section_name[:8] == "BEGIN 1"):
                start_new_document(printer_cfg, is_first_document=True)
            else:
                start_new_document(printer_cfg, is_first_document=False)
            document_open=1

        #################################################################
        # End document
        #################################################################
        elif (line[:4] == "END "):
            print_static_text_value(layout_cfg)
            print_document()
            document_open=0

        #################################################################
        # parse every parameter if file is open
        #################################################################
        else:
            if ((len(value) == 2)and(document_open==1)):
                param_name_from_file = value[0]
                param_value = value[1]
                for postfix in ["", "_1", "_2", "_3"]: # this makes it possible to print out several types for one value
                    param_name = param_name_from_file + postfix
                    if layout_cfg.has_section(param_name):
                        if (layout_cfg.get(param_name, "type") == "text"):
                            print_text_value(dict(layout_cfg.items(param_name)), param_value)
                            if (layout_cfg.get(param_name, "type") == "qmatrix"):
                                print_qmatrix_value(dict(layout_cfg.items(param_name)), param_value)

                                if (layout_cfg.get(param_name, "type") == "image_url"):
                                    print_image_url_value(dict(layout_cfg.items(param_name)), param_value)
                                else:
                                    if(layout_cfg.get(param_name, "type") == "image_xml"):
                                        if(param_value!=""):
                                            print_image_xml_value(dict(layout_cfg.items(param_name)), param_value)
                                        else:
                                            if (layout_cfg.get(param_name, "type") == "bar_2_of_5"):
                                                print_bar_2_of_5_value(dict(layout_cfg.items(param_name)), param_value)
                                                if layout_cfg.has_section("%s_text" % param_name):
                                                    print_text_value(dict(layout_cfg.items("%s_text" % param_name)), param_value)
                                                else:
                                                    if (layout_cfg.get(param_name, "type") == "bar_3_of_9"):
                                                        print_bar_3_of_9_value(dict(layout_cfg.items(param_name)), param_value)
                                                        if layout_cfg.has_section("%s_text" % param_name):
                                                            print_text_value(dict(layout_cfg.items("%s_text" % param_name)), param_value)
                                                        else:
                                                            if (layout_cfg.get(param_name, "type") == "bar_code128"):
                                                                print_code128_value(dict(layout_cfg.items(param_name)), param_value)
                                                                if layout_cfg.has_section("%s_text" % param_name):
                                                                    print_text_value(dict(layout_cfg.items("%s_text" % param_name)), param_value)
                                                                else:
                                                                    logger.warning("unknown type for section:%s" % param_name)
                                                                    set_exit_status(UNKNOWN_TYPE_FOR_SECTION)
                    else:
                        pass
                        # set_exit_status(NO_SUCH_SECTION)

    # continue
    infile.close()

    # do not delete file as this might be bad version right after upgrade
    # if(skip_file_delete==0):
    #     try:
    #         pass
    #         os.remove(plp_filename)
    #     except:
    #         set_exit_status(COULD_NOT_DELETE_PLP)
    #         pass
    #         f.fileno ()
    #         os.close(infile.fileno())

#################################################################
# Log available printer name on the system
#################################################################
def print_available_printers():
    # return
    logger.info("local printers: {0}".format(win32print.EnumPrinters(win32print.PRINTER_ENUM_LOCAL)))
    logger.info("network printers:{0}".format(win32print.EnumPrinters(win32print.PRINTER_ENUM_CONNECTIONS)))
    logger.info("default printer:{0}".format(win32print.GetDefaultPrinter()))

#################################################################
# Read ini filename into cfg structure
#################################################################
def read_ini_config(ini_file):
    cfg = ConfigParser.ConfigParser()
    ini_file_full_path = ini_file
    logger.info("trying to read ini file from file:[%s] ..."%ini_file_full_path)
    ret = cfg.read(ini_file_full_path)
    if(len(ret)==0):
        return None
    else:
        return cfg

#################################################################
# important for installation file????
#################################################################
def main_is_frozen():
    return (hasattr(sys, "frozen") # new py2exe
    or hasattr(sys, "importers") # old py2exe
    or imp.is_frozen("__main__")) # tools/freeze

#################################################################
# Find absolute path for this file when exacuted
#################################################################
def get_main_dir():
    if main_is_frozen():
        return os.path.dirname(sys.executable)
    return os.path.realpath(os.path.dirname(sys.argv[0]))

#################################################################
# Layout file downloaded from EE has \00 chars in the end of file
#################################################################
def strip_file_null_chars(fname):
    with open(fname, "r") as in_f:
        content = in_f.read().rstrip("\0\n")

    with open(fname, "w") as out_f:
        out_f.write(content)

#################################################################
# Layout url may be speciffied in plp file right after BEGIN line
#################################################################
def get_layout_cfg(file_url):
    global proxy
    logger.info("getting layout file:%s"%file_url)

    file_url_parts = urlparse.urlsplit(file_url)
    if (len(file_url_parts) == 5):

        local_file_filename = os.path.join(get_main_dir(), "layouts", file_url_parts[2].replace("/", "_"))
        logger.info("layouts file:%s"%local_file_filename)

        # check to see if we have the file available localy
        if not os.path.isfile(local_file_filename):
            logger.info("no file found in local folder. will try to download ...")
            try:
                file_url = file_url.encode("utf-8")
                local_file_filename = local_file_filename.encode("utf-8")
                # use proxy class wrap to urllib to download image if proxy is set
                if(proxy == None):
                    ret = urllib.urlretrieve(file_url, local_file_filename)
                else:
                    urlprx = UrllibProxy(proxy)
                    ret = urlprx.urlretrieve(file_url, local_file_filename)
                logger.info("layouts file download successful:%s" % local_file_filename)
                strip_file_null_chars(local_file_filename)
                return read_ini_config(local_file_filename) # reading freshly downloaded copy
            except urllib2.HTTPError, e:
                logger.error("Could not download image:%s. Got error code:%s" % (file_url, e.code))
                set_exit_status(COULD_NOT_DOWNLOAD_URL_LAYOUT)
            except:
                logger.error("got exception while getting or parsing ini file")
        else:
            logger.info("found layouts file %s local copy" % local_file_filename)
            strip_file_null_chars(local_file_filename)
            return read_ini_config(local_file_filename) # reading local copy
    else:
        logger.error("len(file_url_parts)!=5. Exiting ...")
    return None

#################################################################
def read_plp_in_array(fname):
    ret = {}
    with open(fname) as f:
        content = f.readlines()
    for line in content:
        params = line.split("=")
        if len(params)==2:
            key = params[0].strip("\n\r ")
            val = params[1].strip("\n\r ")
            ret[key] = val
    return ret

#################################################################
def read_plp_in_cfg(fname):
    ret = {}
    section="DEFAULT"
    cfg = ConfigParser.ConfigParser()
    with open(fname) as f:

        content = f.readlines()
    for line in content:
        if line.startswith(codecs.BOM_UTF8):
            line = line[3:]
        params = line.split("=")
        if len(params)==2:
            key = params[0].strip("\n\r ")
            val = params[1].strip("\n\r ")
            if((not cfg.has_section(section)) and (section!="DEFAULT")):
                cfg.add_section(section)
            cfg.set(section,key,val)
        elif(line[:5]=="BEGIN"):
            section = line.strip("\n\r ")
        else:
            # probably "END 1", "END 2" etc. here
            pass
    return cfg

#################################################################
def setup_proxy(cfg):
    proxy = None
    try:
        proxy = cfg.get("DEFAULT", "http_proxy")
        logger.info("http proxy set:[%s]"%proxy)
    except:
        logger.info("no http proxy set")

    if(proxy!=None):
        proxy_handler = urllib2.ProxyHandler({
            "http": proxy,
            "https": proxy
        })
        opener = urllib2.build_opener(proxy_handler)
        urllib2.install_opener(opener)
    return proxy

#################################################################
def auto_update_callback(data):
    #"auto_update_callback:", data["status"]
    logger.info("auto_update_callback: {0}".format(data))

#################################################################
def override_cfg_values(cfg_1, cfg_2):
    if(cfg_1 is None) and (cfg_2 is None):
        logger.error("cfg_1=None and cfg_2=None ")
        return None
    if(cfg_1 is None):
        logger.error("cfg_1=None")
        return cfg_2
    if(cfg_2 is None):
        logger.error("cfg_2=None")
        return cfg_1

    # cfg_2 overrides cfg_1
    cfg_1_defaults = cfg_1.defaults()
    logger.info("cfg_1 defaults %s" % cfg_1_defaults)
    cfg_2_defaults = cfg_2.defaults()
    logger.info("cfg_2 defaults %s" % cfg_2_defaults)

    cfg_2_sections = cfg_2.sections()
    cfg_2_sections.extend(["DEFAULT"])
    logger.info("cfg_2_sections: %s" % cfg_2_sections)
    for section in cfg_2_sections:
        # each section can have disable_override value that lists parameters not to be overriden
        if(cfg_1.has_option(section, "disable_override")):
            disable_override_list = cfg_1.get(section, "disable_override").strip("\"").split(",")
        else:
            disable_override_list = []
        logger.info("disable_override_list: %s" % disable_override_list)


        if((not cfg_1.has_section(section))and section!="DEFAULT"):
            cfg_1.add_section(section)

        # cfg_2.options(section) fails if section="DEFAULT"
        if(section=="DEFAULT"):
            option_list = cfg_2.defaults()
        else:
            option_list = cfg_2.options(section)
        for option in option_list:
            #"[%s](%s)"%(section,option)
            if(cfg_1.has_option(section, option)):

                old_value = cfg_1.get(section, option)
                new_value = cfg_2.get(section, option)
                if(old_value!=new_value):

                    if(option not in disable_override_list):
                        logger.info("overriding [%s](%s) from '%s' to '%s'" % (section,option,old_value,new_value))
                        if(option=="disable_override"):
                            # inherit disable_override params so that plp values does not override persistent.ini values
                            # if in setup.ini has own disable_override values
                            cfg_1.set(section, option, "%s,%s"%(cfg_1.get(section, option),cfg_2.get(section, option)))
                        else:
                            cfg_1.set(section, option, cfg_2.get(section, option))
                    else:
                        logger.info("disable_override for [%s](%s)"%(section,option))
                else:
                    # values are the same in both config
                    pass
            else:
                # adding new option
                cfg_1.set(section, option, cfg_2.get(section, option))
                pass


    return cfg_1

#################################################################
def get_ready_for_update_msg_text(cfg, v1, v2):
    lang = get_lang(cfg)
    if(lang == "lv"):
        return (u"Gatavi veikt printera programmas atjaunināšanu no %s uz %s?"%(v1,v2), u"Atjauninājums!")
        pass
    elif(lang == "ee"):
        return (u"Ready for ticket printer update from %s to %s?"%(v1,v2), u"Update!")
        pass
    elif(lang == "by"):
        return (u"Готовы для обновления принтера билет от %s к %s?"%(v1,v2), u"Oбновления!")
        pass
    else:
        return (u"Ready for ticket printer update from %s to %s?"%(v1,v2), u"Update!")
        pass

#################################################################
# This function gets used for both: update and rollback downgrade in case tickets did not print OK
#################################################################
def do_auto_update(cfg, current_version, downgrade = False, downgrade_version = False, prev_version=False):
    # Set my_id to identify ourselves when requesting update
    logger.info("getting my id ...")
    try:
        my_id = cfg.get("DEFAULT", "my_id").strip("\"")
        logger.info("my_id:%s"%my_id)
    except:
        my_id = "MY_ID_NOT_SET"
        logger.info("my_id not set. using default: ", my_id)

    # Set updates_base_url where we will look for updates
    try:
        updates_base_url = cfg.get("DEFAULT", "updates_base_url").strip("\"")
    except:
        updates_base_url = r"http://www.4scan.lv/printsrv/updates/"
        logger.warning("updates_base_url not set. using default")

    ret_do_not_delete_plp_file = False

    # ESKY
    if getattr(sys,"frozen",False):

        url_args = {"my_id":my_id, "my_version":current_version, "getnode":hex(getnode())}
        if(downgrade_version!=False):
            # we inform server and server should take care of not showing the bad version to us ever again.
            url_args["downgrade_version"] = downgrade_version;
        if(downgrade == True):
            url_args["downgrade"] = 1;
        if(prev_version!=False):
            url_args["prev_version"] = prev_version;
        app = esky.Esky(sys.executable,"%s?%s"%(updates_base_url, urllib.urlencode(url_args)))
        if(downgrade_version!=False):
            logger.info("clean up that bad version we had to downgrade from. try to uninstall it")
            #lockfile = os.path.join(vdir,ESKY_CONTROL_DIR,"bootstrap-manifest.txt")
            #unlock_version_dir()
            #app.uninstall_version(downgrade_version)
            #app.cleanup() # this is not good. it restores the downgraded version. we need to manually delete the downgraded version folder
            # TODO. make own version of downgrade_cleanup(downgrade_version)
        logger.info("You are running: %s" % app.active_version)
        try:
            print "active:[%s], cfg:[%s]"%(app.active_version,cfg.get("DEFAULT", "driver_version"))
            need_update = False
            planned_update_version = None
            if cfg.get("DEFAULT", "driver_version")=="auto":
                planned_update_version = app.find_update()
                if(planned_update_version != None):
                    need_update = True
            else:
                planned_update_version = cfg.get("DEFAULT", "driver_version").strip("\"\r\n ")
                if(app.active_version != planned_update_version):
                    need_update = True

            if(need_update==True):
                # plp file can override update choice
                if(cfg.get("DEFAULT", "driver_force_upgrade") == "yes"):
                    ret = 1
                else:
                    msg, title = get_ready_for_update_msg_text(cfg, app.active_version, planned_update_version)
                    ret = windll.user32.MessageBoxW(0, msg, title, 1)
                print "MessageBoxA ret:", ret
                if ret == 1:
                    # OK response
                    logger.info("doing auto_update ...")
                    if cfg.get("DEFAULT", "driver_version")=="auto":
                        #app.auto_update(auto_update_callback)
                        #version = app.find_update() # this needs to be called before "app._do_auto_update"
                        app.fetch_version(planned_update_version,auto_update_callback)
                        app.install_version(planned_update_version)
                        ret_do_not_delete_plp_file = True
                        # skip uninstall_version
                    else:
                        version = app.find_update() # this needs to be called before "app._do_auto_update"
                        logger.info("found best version:", version)
                        #app._do_auto_update(planned_update_version,auto_update_callback)
                        #######
                        if(downgrade):
                            #we are downgrading. should be enaugh to just uninstall the current version


                            logger.info("downgrading. fetch_version()")
                            app.fetch_version(planned_update_version,auto_update_callback)
                            logger.info("downgrading. do install_version")
                            app.install_version(planned_update_version)
                            logger.info("downgrading. do uninstall_version")
                            logger.info("self.appdir: %s" % app.appdir)
                            logger.info("os.path.realpath(./): %s" % os.path.realpath("./"))
                            try:
                                app.uninstall_version(current_version)
                                logger.info("done uninstall_version")
                            except:
                                logger.info(traceback.format_exc())
                                logger.info("exception while doing uninstall_version. Will try to fool the bootstrap ...")
                                directory = "%s/esky-files/bootstrap"%get_main_dir()
                                logger.info("creating directory:",directory)
                                if not os.path.exists(directory):
                                    os.makedirs(directory)
                            pass
                            app.reinitialize()
                            logger.info("done reinitialize()")
                            #app.cleanup()
                            #logger.info("done cleanup()")
                            ret_do_not_delete_plp_file = True
                        else:
                            app.fetch_version(planned_update_version,auto_update_callback)
                            #callback({"status":"installing", "new_version":version})
                            app.install_version(planned_update_version)
                            try:
                                pass
                                #app.uninstall_version(current_version)
                            except VersionLockedError:
                                pass
                            app.reinitialize()
                            ret_do_not_delete_plp_file = True
                        #######

                    appexe = esky.util.appexe_from_executable(sys.executable)
                    if(downgrade):
                        argv_to_pass = []
                        for argv in sys.argv[1:]:
                            # we don't want to do downgrade from the downgrade we just did
                            if(not argv.startswith("--prev_version=")):
                                argv_to_pass.extend([argv])
                            argv_to_pass.extend(["--downgrade_version=%s"%current_version])
                        logger.info("downgrade finished. Will do restart with args:",argv_to_pass)
                        ret_do_not_delete_plp_file = True
                        os.execv(appexe,[appexe] + argv_to_pass)
                        pass
                    else:
                        logger.info("update finished. Will do restart with args:",sys.argv[1:],["--prev_version=%s"%current_version])
                        ret_do_not_delete_plp_file = True
                        os.execv(appexe,[appexe] + sys.argv[1:] + ["--prev_version=%s"%current_version])
                    logger.info("after updater os.execv call")
                elif ret == 2:
                    # CANCEL response
                    logger.info("update canceled")
                else:
                    # ??
                    pass

        #except Exception, e:
        except KeyError:
            logger.error("KeyError while updating app ", e)
            logger.debug(traceback.format_exc())
        except Exception, e:
            logger.error("exception when updating app")
            logger.debug(traceback.format_exc())
        #app.cleanup()
        return ret_do_not_delete_plp_file

#################################################################
def usage():
    print ""
    print "Usage: %s [-V] [-v|verbose] [-h|--help] [--skip_file_delete] [--ini_file=filename] plp_file"%sys.argv[0]
    print ""
    print "Options:"
    print "   -V                             print version and exit"
    print "   -v --verbose                   be verbose"
    print "   -h --help                      show usage"
    print "   --skip_file_delete             skip plp file deletion after printing"
    print "   --ini_file=<filename>          use alternate ini file than default setup.ini. must reside in the same folder"
    print "   --prev_version=<version>       if printsrv is run for the first time with new version"
    print "   --downgrade_version=<version>  we have just started after downgrade"
    print "   --list_printer_fonts=<printer> list all fonts"
    print ""

#################################################################
def get_post_update_msg_text(cfg):
    lang = get_lang(cfg)
    if(lang == "lv"):
        return (u"Biļetes izprintējās labi?", u"Pārbaude!")
        pass
    elif(lang == "ee"):
        return (u"Did the tickets print OK?", u"Check tickets!")
        pass
    elif(lang == "by"):
        return (u"Билеты напечатаны в порядке?", u"Билеты порядке?")
        pass
    else:
        return (u"Did the tickets print OK?", u"Check tickets!")
        pass

#################################################################
def do_post_update_check(cfg, current_version, prev_version):
    #msg_box_text = u"Did the tickets print OK?\n Biļetes izprintējās labi?\n Билеты напечатаны в порядке?"
    msg, title = get_post_update_msg_text(cfg)
    #"MessageBoxW text:[%s]"%msg_box_text
    # YESNO = 4
    ret = windll.user32.MessageBoxW(0, msg, title, 4)
    if ret == 6:
        # YES response
        logger.info("tickets printed OK")
    elif ret == 7:
        # NO response
        # do downgrade
        logger.info("tickets did not print OK. Doing downgrade from %s to %s"%(current_version, prev_version))
        cfg.set("DEFAULT", "driver_force_upgrade", "yes")
        cfg.set("DEFAULT", "driver_version", prev_version)
        do_auto_update(cfg, current_version, prev_version=prev_version, downgrade = True)

    else:
        # ??
        logger.error("unknown response from MessageBoxW:%s, expecting 6[YES] or 7[NO]"%ret)
        pass

#################################################################
def get_lang(cfg):
    return cfg.get("DEFAULT","my_id")[0:2].lower()

def font_list_callback(font, tm, fonttype, fonts):
    # if(font.lfFaceName == fonts[0]):
    #     fonts.append(font)
    logger.info(" %s" % font.lfFaceName)
    return True

#################################################################
# try to force file removal
def handleRemoveReadonly(func, path, exc):
    excvalue = exc[1]
    if func in (os.rmdir, os.remove) and excvalue.errno == errno.EACCES:
        os.chmod(path, stat.S_IRWXU| stat.S_IRWXG| stat.S_IRWXO) # 0777
        func(path)
    else:
        raise


################################################################################
# MAIN STARTS HERE
################################################################################

logging.config.fileConfig(get_main_dir() + "//logger.ini")

# redirect STDOUT to log file
stdout_logger = logging.getLogger("STDOUT")
sl = StreamToLogger(stdout_logger, logging.INFO)
sys.stdout = sl

# redirect STDERR to log file
stderr_logger = logging.getLogger("STDERR")
sl = StreamToLogger(stderr_logger, logging.ERROR)
sys.stderr = sl


# create logger
logger = logging.getLogger("printsrv")

logger.info("starting version %s"%version.VERSION)
print_available_printers()


# Parse command line arguments
try:
    opts, args = getopt.gnu_getopt(sys.argv[1:], "hvV", ["help", "verbose", "skip_file_delete", "ini_file=", "prev_version=", "downgrade_version=", "list_printer_fonts="])
except getopt.GetoptError as err:
    # Output help information and exit:
    logger.error(str(err)) # will print something like "option -a not recognized"
    usage()
    set_exit_status(HELP_MESSAGE)
    sys.exit(EXIT_STATUS)

verbose = False
ini_filename = False
skip_file_delete = True
prev_version = False
downgrade_version = False

for o, a in opts:
    if o in ("-v", "--verbose"):
        verbose = True
    elif o == "-V":
        print version.VERSION
        sys.exit(EXIT_STATUS)
    elif o in ("-h", "--help"):
        usage()
        set_exit_status(HELP_MESSAGE)
        sys.exit(EXIT_STATUS)
    elif o in ("--ini_file"):
        ini_filename = a
        logger.info("found --ini_file= parameter with value:[%s]"%ini_filename)
    elif o in ("--skip_file_delete"):
        skip_file_delete = True
        logger.info("found --skip_file_delete parameter")
    elif o in ("--prev_version"):
        # we have just started after upgrade
        prev_version = a
        skip_file_delete = True
        logger.info("found --prev_version parameter with value:[%s]"%prev_version)
    elif o in ("--downgrade_version"):
        # we have just started after downgrade
        downgrade_version = a
        skip_file_delete = True
        logger.info("found --downgrade_version parameter with value:[%s]"%downgrade_version)
    elif o in ("--list_printer_fonts"):
        tmp_printer = a
        hprinter = win32print.OpenPrinter(tmp_printer)
        devmode = win32print.GetPrinter(hprinter, 2)["pDevMode"]
        printjobs = win32print.EnumJobs(hprinter, 0, 999)
        hdc = win32gui.CreateDC("WINSPOOL", tmp_printer, devmode)
        dc = win32ui.CreateDCFromHandle(hdc)
        fonts = []
        win32gui.EnumFontFamilies(hdc, None, font_list_callback,fonts)
        sys.exit(EXIT_STATUS)
    else:
        assert False, "unhandled option"
if(len(args)==1):
    plp_filename = args[0].strip("\"")
else:
    logger.error("File not specified as first argument\n")
    set_exit_status(PLP_FILE_NOT_SPECIFIED)
    sys.exit(EXIT_STATUS)

# things like proxy, my_id are stored in persistent.ini

persistent_ini_filename = "persistent.ini"
persistent_ini_path = os.path.join(get_main_dir(), persistent_ini_filename)
if not os.path.isfile(persistent_ini_path):
    persistent_ini_path = os.path.join(get_main_dir(), "..", persistent_ini_filename)
if not os.path.isfile(persistent_ini_path):
    persistent_ini_path = os.path.join(get_main_dir(), "..", "..", persistent_ini_filename)
if not os.path.isfile(persistent_ini_path):
    logger.error("ERROR: persistent.ini could not be found")
    sys.exit(EXIT_STATUS)
cfg_persistent = read_ini_config(persistent_ini_path) # when running from first install

if(ini_filename==False):
    ini_filename = get_main_dir() + "\\setup_%s.ini"%get_lang(cfg_persistent)
    logger.info("setting ini filename to:%s"%ini_filename)

# default layout
cfg_setup = read_ini_config(ini_filename)

# setup.ini overrides persistent.ini values if there are any
cfg = override_cfg_values(cfg_persistent, cfg_setup)

logger.info("plp filename:[%s]"%plp_filename)

cfg_plp = read_plp_in_cfg(plp_filename)
# plp overrides persistent.ini and setup.ini values if there are any
logger.debug("Print cfqg DEFAULT after read_plp_in_cfg")
logger.debug(cfg_plp.defaults())

cfg = override_cfg_values(cfg, cfg_plp)

proxy = setup_proxy(cfg)

logger.debug({"argv":sys.argv, "len":len(sys.argv)})


if do_auto_update(cfg, version.VERSION, downgrade_version=downgrade_version, prev_version=prev_version):
    skip_file_delete = True

logger.debug("Print cfg before read_plp_file")
logger.debug(cfg.defaults())

if(cfg_plp.has_option("DEFAULT", "info") and cfg_plp.get("DEFAULT", "info")=="fiscal"):
   shtrih_fp_f = ecr.ECR_Object()
   shtrih_fp_f.Connect(cfg)
   shtrih_fp_f.ParsePLP(cfg)
   shtrih_fp_f.Close()
   del shtrih_fp_f
   pass
else:
   read_plp_file(cfg, plp_filename, skip_file_delete)

if(prev_version!=False):
    # this is first run after update
    #do_post_update_check(cfg, version.VERSION, prev_version)
    logger.info("skipping post_update_check as users can not be trusted.")

if(skip_file_delete==False):
    try:
        logger.info("doing file delete for file:[%s]"%plp_filename)
        os.remove(plp_filename)
        #shutil.rmtree(plp_filename, ignore_errors=False, onerror=handleRemoveReadonly)
        pass
    except:
        logger.debug("WARNING: Exception when doing file delete. Will retry with chmod 777")
        logger.debug(traceback.format_exc())
        os.chmod(plp_filename, stat.S_IRWXU| stat.S_IRWXG| stat.S_IRWXO) # 0777
        os.remove(plp_filename)
        pass
logger.info("exit status:%d"%EXIT_STATUS)
sys.exit(EXIT_STATUS)
