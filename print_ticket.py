# coding: utf-8
# Written by Janis Putrams for "Biļešu Serviss SIA"
# janis.putrams@gmail.com
# Rewrite by Mihkel Putrinš
#    from July 29, 2016 to May 1, 2017

import                  win32ui
import                  win32gui
import                  win32print
from ctypes      import windll
import                  ConfigParser
from os          import path, makedirs
import                  requests
import                  urllib
import                  urllib2
import                  urlparse
from PIL         import Image, ImageWin
import                  string
import                  wmi
from json        import load as loadJSON, dumps as dumpsJSON
from yaml        import load as loadYAML
from UrllibProxy import UrllibProxy
import                  sys
import                  qrcode
import                  qrcode.image.pil
import                  errno, stat, shutil


ERROR_CODES = {
    "EXIT_OK"                       : 0      ,
    "COULD_NOT_OPEN_PRINTER"        : 2 ** 0 , #         1
    "COULD_NOT_CREATE_DC"           : 2 ** 1 , #         2
    "NO_SUCH_FONT_AVAILABLE"        : 2 ** 2 , #         4
    "UNABLE_TO_CREATE_FONT"         : 2 ** 3 , #         8
    "CANT_DECODE_AS_UTF8"           : 2 ** 4 , #        16
    "NO_IMAGE_BY_THAT_NAME"         : 2 ** 5 , #        32
    "UNSUPPORTED_IMAGE_FORMAT"      : 2 ** 6 , #        64
    "COULD_NOT_DOWNLOAD_XML_IMAGE"  : 2 ** 7 , #       128
    "COULD_NOT_DOWNLOAD_URL_IMAGE"  : 2 ** 8 , #       256
    "EXCEPTION_IN_2_OF_5"           : 2 ** 9 , #       512
    "EXCEPTION_IN_3_OF_9"           : 2 ** 10, #     1 024
    "EXCEPTION_IN_CODE128"          : 2 ** 11, #     2 048
    "UNKNOWN_TYPE_FOR_SECTION"      : 2 ** 12, #     4 096
    "NO_SUCH_SECTION"               : 2 ** 13, #     8 192
    "COULD_NOT_DELETE_PLP"          : 2 ** 14, #    16 384
    "PLP_FILE_NOT_SPECIFIED"        : 2 ** 15, #    32 768
    "PRINTER_IS_OFFLINE"            : 2 ** 16, #    65 536
    "DC_NOT_CREATED"                : 2 ** 17, #   131 072
    "HDC_NOT_CREATED"               : 2 ** 18, #   262 144
    "HELP_MESSAGE"                  : 2 ** 19, #   524 288
    "COULD_NOT_DOWNLOAD_URL_LAYOUT" : 2 ** 20, # 1 048 576
    "PLP_FILENAME_NOT_IN_ENVIRON"   : 2 ** 21, # 2 097 152
    "PLP_FILE_WITHOUT_INFO"         : 2 ** 22 # 4 194 304
}

DEVICE_CONTEXT_HANDLE = None # pylint: disable=C0103
DEVICE_CONTEXT = None # pylint: disable=C0103


#################################################################
def exit_with_status(status):
    print ('Sending "{0}:{1}" to "{2}"'.format(ERROR_CODES[status], status, PLP_JSON_DATA['feedbackUrl']))
    # http_response = requests.post(PLP_JSON_DATA['feedbackUrl'], data=payload, headers={ 'content-type': "application/json" })
    sys.exit(ERROR_CODES[status])

#################################################################
# for code128 used info from http://grandzebu.net/index.php?page=/informatique/codbar-en/code128.htm
#################################################################
def translate_to_code128(chaine):
    def testnum(chaine):
        for i in chaine:
            if not i in string.digits:
                return False
        return True
    Code128 = ""
    tableB=True
    i = 0
    while i < len(chaine):
        if tableB == True:
            #"B == 1a"
            if i < len(chaine) - 4:
                if testnum(chaine[i:4]):
                    if i == 0:
                        #"START_C"
                        Code128 = chr(210) #f
                    else:
                        #"CODE_C"
                        Code128 = Code128 + chr(204) #f
                    tableB = False
                else:
                    if i == 0:
                        #"START_B"
                        Code128 = chr(209) #f
                        tableB = True
            else:
                if i == 0:
                    #"START_B"
                    Code128 = chr(209) #f
                    tableB = True
        if tableB == False:
            #"B == 0"
            if testnum(chaine[i:i+2]) and i <= (len(chaine) - 2):
                dummy = int(chaine[i:i+2])
                if dummy < 95:
                    dummy += 32
                else:
                    dummy += 105 #f
                Code128 = Code128 + chr(dummy)
                i = i + 2
            else:
                #"TABLE_C->CODE_B"
                Code128 = Code128 + chr(205) #f
                tableB = True
        if tableB == True:
            #"B==1b"
            Code128 = Code128 + chaine[i]
            i = i + 1
    for i, dum in enumerate(Code128):
        dummy = ord(dum)
        if dummy < 127:
            dummy -= 32
        else:
            dummy -= 105 #f
        if i == 0:
            checksum = dummy
        checksum += i * dummy
        while checksum >= 103: # mod 103
            checksum -= 103
    if checksum < 95:
        checksum += 32
    else:
        checksum += 105 #f
    Code128 = Code128 + chr(checksum) + chr(211)
    return Code128

#################################################################
def translate_to_3_of_9(code):
    return "*{0}*".format(code)

#################################################################
def translate_to_2_of_5(code):
    length = len(code)
    at = 0
    ret = ""
    while at < length:
        tmp = int("{0}{1}".format(code[at], code[at + 1]))
        if tmp < 94:
            tmp = tmp + 33
        else:
            tmp = tmp + 101
        ret = "{0}{1}".format(ret, chr(tmp))
        at = at + 2

    return "{0}{1}{2}".format(chr(201), ret, chr(202))

#################################################################
def is_printer_online(printer_name):
    for wmi_printer in wmi.WMI().Win32_Printer ():
        # print("printer_name {0} =? wmi_printer.caption {1}".format(printer_name, wmi_printer.caption))
        if printer_name == wmi_printer.caption:
            if wmi_printer.WorkOffline:
                print("E: Printer {0} is offline.".format(printer_name))
                return False
            else:
                # print("Printer {0} is online.".format(printer_name))
                return True

#################################################################
def start_new_document(is_first_document = False):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    global EXIT_STATUS

    # printer = cfg.get("DEFAULT", "printer_name")
    printer = PLP_JSON_DATA['ticketData']['printerData']['printerName']
    retry_times_left = 3
    # Display message box if printer is not online. Retry 3 times
    while not is_printer_online(printer):
        ret = windll.user32.MessageBoxW(0, "Check printer and click OK when ready!".decode(), "Check printer!".decode(), 0x40 | 0x0) #OK only
        retry_times_left -= 1
        if retry_times_left <= 0:
            print("E: Printer {0} is offline. Exiting.".format(printer))
            exit_with_status('PRINTER_IS_OFFLINE')

    try:
        hprinter = win32print.OpenPrinter(printer)
    except:
        print("E: exception while opening printer");
        exit_with_status('COULD_NOT_OPEN_PRINTER')
    # print("win32print.GetPrinter")
    devmode = win32print.GetPrinter(hprinter, 2)["pDevMode"]
    # print("win32print.EnumJobs")
    printjobs = win32print.EnumJobs(hprinter, 0, 999)
    # print("Jobs: {0}".format(printjobs))

    # if this is first document then there should be no documents in printer queue
    if is_first_document:
        retry_times_left = 3
        while len(printjobs) != 0:
            ret = windll.user32.MessageBoxW(0, "Check printer and click OK when ready!".decode(), "Check printer!".decode(), 0x40 | 0x0) #OK only
            retry_times_left -= 1
            if retry_times_left <= 0:
                print("E: Printer has old jobs in queue. Exiting")
                # exit_with_status('PRINTER_IS_OFFLINE')

    try:
        devmode.Orientation = 2
    except:
        print("Setting orientation failed: {0}".format(sys.exc_info()[0]))
    try:
        print("win32gui.CreateDC")
        DEVICE_CONTEXT_HANDLE = win32gui.CreateDC("WINSPOOL", printer, devmode)
        print("win32ui.CreateDCFromHandle")
        DEVICE_CONTEXT = win32ui.CreateDCFromHandle(DEVICE_CONTEXT_HANDLE)
    except:
        print("E: exception while creating DEVICE_CONTEXT")
        exit_with_status('COULD_NOT_CREATE_DC')
    if DEVICE_CONTEXT == None:
        print("E: DEVICE_CONTEXT not created")
        exit_with_status('DC_NOT_CREATED')
    if DEVICE_CONTEXT_HANDLE == None:
        print("E: DEVICE_CONTEXT_HANDLE not created")
        exit_with_status('HDC_NOT_CREATED')

    print("DEVICE_CONTEXT.SetMapMode")
    DEVICE_CONTEXT.SetMapMode(1)
    print("DEVICE_CONTEXT.StartDoc")
    DEVICE_CONTEXT.StartDoc("ticket.txt")
    print("DEVICE_CONTEXT.StartPage")
    DEVICE_CONTEXT.StartPage()
    print("win32ui.CreateFont");
    font = win32ui.CreateFont({"name": "Arial", "height": 16})
    print("DEVICE_CONTEXT.SelectObject")
    DEVICE_CONTEXT.SelectObject(font)
    print("DEVICE_CONTEXT.SelectObject DONE")

#################################################################
def rgb2int(R, G, B):
    return R + G * 256 + B * 256 * 256

#################################################################
def print_document():
    DEVICE_CONTEXT.EndPage()
    DEVICE_CONTEXT.EndDoc()

#################################################################
def set_section_font_indirect(section_cfg, postfix = ""):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    fonts=[section_cfg["font_name"+postfix]]
    def callback(font, tm, fonttype, fonts):
        if font.lfFaceName == fonts[0]:
            fonts.append(font)
        return True
    win32gui.EnumFontFamilies(DEVICE_CONTEXT_HANDLE, None, callback,fonts)
    # lf = win32gui.LOGFONT()
    try:
        log_font = fonts[1]
    except:
        print("No such font available:{0}".format(section_cfg["font_name"+postfix]))
        exit_with_status('NO_SUCH_FONT_AVAILABLE')
        log_font = win32gui.LOGFONT()
    try:
        log_font.lfHeight = int(section_cfg["font_height"+postfix])
    except:
        pass

    try:
        log_font.lfWidth = int(section_cfg["font_width"+postfix])
    except:
        pass
    try:
        log_font.lfWeight = int(section_cfg["font_weight"+postfix])
    except:
        pass
    try:
        #log_font.lfOrientation = int(90)*10
        #log_font.lfEscapement = int(90)*10
        log_font.lfOrientation = int(section_cfg["font_orientation"+postfix])*10
        log_font.lfEscapement = int(section_cfg["font_orientation"+postfix])*10
    except:
        pass
    font_handle = win32gui.CreateFontIndirect(log_font)
    if not font_handle:
        raise StandardError("ERROR: Unable to create font")
    try:
        DEVICE_CONTEXT.SetTextColor(rgb2int(int(section_cfg["font_color_red"+postfix]), int(section_cfg["font_color_green"+postfix]), int(section_cfg["font_color_blue"+postfix])))
    except:
        DEVICE_CONTEXT.SetTextColor(rgb2int(0, 0, 0))
    font_handle = win32gui.SelectObject(DEVICE_CONTEXT_HANDLE, font_handle)

#################################################################
def set_section_font(section_cfg, postfix = ""):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    font_params = {}
    font_params["name"] = section_cfg["font_name" + postfix]
    font_params["height"] = int(section_cfg["font_height" + postfix])
    try:
        font_params["width"] = int(section_cfg["font_width" + postfix])
    except:
        pass
    try:
        font_params["weight"] = int(section_cfg["font_weight" + postfix])
    except:
        pass
    font = win32ui.CreateFont(font_params)
    try:
        DEVICE_CONTEXT.SetTextColor(rgb2int(int(section_cfg["font_color_red" + postfix]), int(section_cfg["font_color_green" + postfix]), int(section_cfg["font_color_blue" + postfix])))
    except:
        DEVICE_CONTEXT.SetTextColor(rgb2int(0, 0, 0))
    DEVICE_CONTEXT.SelectObject(font)

#################################################################
def print_text_value(section_cfg, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE

    try:
        value = value.replace(section_cfg["replace_from"], section_cfg["replace_to"])
    except:
        pass
    try:
        value = unicode( value, "utf-8" )
    except:
        print("can't decode:{0}".format(value))
        exit_with_status('CANT_DECODE_AS_UTF8')

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

    print('print_text_value {0} on {1}'.format(value,section_cfg))
    try:
        space = value.rfind(u" ",0,int(section_cfg["font_wrap"]))
        print("wrap {0} found at:{1}".format(int(section_cfg["font_wrap"]), space))
        if space != -1:
            value_w = value[space+1:]
            value = value[0:space]
            space = value_w.rfind(u" ", 0, int(section_cfg["font_wrap"]))
            if space != -1:
                value_ww = value_w[space+1:]
                value_w = value_w[0:space]
    except:
        pass

    try:
        space1 = value1.rfind(u" ", 0, int(section_cfg["font_wrap1"]))
        print("wrap {0} found at:{1}".format(int(section_cfg["font_wrap1"]), space1))
        if space1 != -1:
            value_w1 = value1[space1+1:]
            value1 = value1[0:space1]
            space1 = value_w1.rfind(u" ", 0, int(section_cfg["font_wrap1"]))
            if space1 != -1:
                value_ww1 = value_w1[space1+1:]
                value_w1 = value_w1[0:space1]
    except:
        pass

    try:
        space2 = value2.rfind(u" ", 0, int(section_cfg["font_wrap2"]))
        print(" wrap {0} found at:{1}".format(int(section_cfg["font_wrap2"]), space2))
        if space2 != -1:
            value_w2 = value2[space2+1:]
            value2 = value2[0:space2]
            space2 = value_w2.rfind(u" ", 0, int(section_cfg["font_wrap2"]))
            if space2 != -1:
                value_ww2 = value_w2[space2+1:]
                value_w2 = value_w2[0:space2]
    except:
        pass

    try:
        space3 = value3.rfind(u" ", 0, int(section_cfg["font_wrap3"]))
        print(" wrap {0} found at:{1}".format(int(section_cfg["font_wrap3"]), space3))
        if space3 != -1:
            value_w3 = value3[space3+1:]
            value3 = value3[0:space3]
            space3 = value_w3.rfind(u" ", 0, int(section_cfg["font_wrap3"]))
            if space3 != -1:
                value_ww3 = value_w3[space3+1:]
                value_w3 = value_w3[0:space3]
    except:
        pass

    try:
        set_section_font_indirect(section_cfg, "")
        windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
            int(section_cfg["x"]),
            int(section_cfg["y"]),
            value, len(value) )
        try:
            set_section_font_indirect(section_cfg, "")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x"]),
                int(section_cfg["y"]) + int(section_cfg["font_height"]),
                value_w, len(value_w) )
            set_section_font_indirect(section_cfg, "")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x"]),
                int(section_cfg["y"]) + 2 * int(section_cfg["font_height"]),
                value_ww, len(value_ww) )
        except:
            pass
        set_section_font_indirect(section_cfg, "1")
        windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
            int(section_cfg["x1"]),
            int(section_cfg["y1"]),
            value1, len(value1) )
        try:
            set_section_font_indirect(section_cfg, "1")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x1"]),
                int(section_cfg["y1"]) + int(section_cfg["font_height1"]),
                value_w1, len(value_w1) )
            set_section_font_indirect(section_cfg, "1")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x1"]),
                int(section_cfg["y1"]) + 2 * int(section_cfg["font_height1"]),
                value_ww1, len(value_ww1) )
        except:
            pass
        set_section_font_indirect(section_cfg, "2")
        windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
            int(section_cfg["x2"]),
            int(section_cfg["y2"]),
            value2, len(value2) )
        try:
            set_section_font_indirect(section_cfg, "2")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x2"]),
                int(section_cfg["y2"]) + int(section_cfg["font_height2"]),
                value_w2, len(value_w2) )
            set_section_font_indirect(section_cfg, "2")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x2"]),
                int(section_cfg["y2"]) + 2 * int(section_cfg["font_height2"]),
                value_ww2, len(value_ww2) )
        except:
            pass
        set_section_font_indirect(section_cfg, "3")
        windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
            int(section_cfg["x3"]),
            int(section_cfg["y3"]),
            value3, len(value3) )
        try:
            set_section_font_indirect(section_cfg, "3")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x3"]),
                int(section_cfg["y3"]) + int(section_cfg["font_height3"]),
                value_w3, len(value_w3) )
            set_section_font_indirect(section_cfg, "3")
            windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
                int(section_cfg["x3"]),
                int(section_cfg["y3"]) + 2 * int(section_cfg["font_height3"]),
                value_ww3, len(value_ww3) )
        except:
            pass
    except(KeyError):
        pass
    except:
        raise

#################################################################
def print_image(x, y, value, rotate = 0):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    try:
        bmp = Image.open(value)
    except:
        print("E: No image by that name")
        exit_with_status('NO_IMAGE_BY_THAT_NAME')
        return None
    rotate = int(rotate)
    print("rotate={0}".format(rotate))
    if rotate == 90:
        bmp = bmp.transpose(Image.ROTATE_90)
    if rotate == 180:
        bmp = bmp.transpose(Image.ROTATE_180)
    if rotate == 270:
        bmp = bmp.transpose(Image.ROTATE_270)

    try:
        dib = ImageWin.Dib(bmp)
    except:
        print("E: Only jpg and bmp are supported")
        exit_with_status('UNSUPPORTED_IMAGE_FORMAT')
        return None
    dib.draw(DEVICE_CONTEXT.GetHandleOutput(), (int(x), int(y), int(x) + bmp.size[0], int(y) + bmp.size[1]))

#################################################################
def print_qmatrix(x, y, size, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE

    factory = qrcode.image.pil.PilImage

    qr = qrcode.QRCode(
        # version = 1,
        error_correction = qrcode.constants.ERROR_CORRECT_H,
        # box_size = 10,
        # border = 4,
    )
    qr.add_data(value)
    qr.make(fit = True)
    im = qr.make_image(image_factory = factory)

    # im = qrcode.make(value, image_factory = factory)
    try:
        dib = ImageWin.Dib(im)
    except:
        print("E: unsupported image format in print_qmatrix")
        exit_with_status('UNSUPPORTED_IMAGE_FORMAT')
        return None
    dib.draw(DEVICE_CONTEXT.GetHandleOutput(), (int(x), int(y), int(x) + int(size), int(y) + int(size)))

#################################################################
def print_qmatrix_value(section_cfg, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    print_qmatrix(section_cfg["x"], section_cfg["y"], section_cfg["size"], value)

#################################################################
def print_image_value(section_cfg, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    """ This function prints image specified in ini file
        values are x position, y position and value which is full path to the jpg/bmp file
    """
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
def ensure_dir(_path):
    _directory = path.dirname(_path)
    if not path.exists(_directory):
        makedirs(_directory)

#################################################################
def print_image_xml_value(section_cfg, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    global proxy
    """
    This function prints image specified. if it is not available locally it downloads it from web.
    """
    #local_image_filename = section_cfg["local_image_folder"] + value
    # local_image_filename = path.join(get_main_dir(), "img", value)
    ensure_dir(section_cfg["local_image_folder"])
    local_image_filename = path.join(section_cfg["local_image_folder"], value)

    if not path.isfile(local_image_filename):
        try:
            image_url = section_cfg["remote_image_url_folder"] + urllib.quote(value)
            print(" {0}".format(image_url))

            # this gives error if value has non ascii chars.
            # I guess this is trying to double encode to utf-8
            #image_url = image_url.encode("utf-8")
            #image_url = urllib.quote(image_url)
            #local_image_filename = local_image_filename.encode("utf-8")


            # use proxy class wrap to urllib to download image if proxy is set
            if proxy == None:
                print("image_url:{0}, local_image_filename:{1}".format(image_url, local_image_filename))
                ret = urllib.urlretrieve(image_url, local_image_filename)
            else:
                urlprx = UrllibProxy(proxy)
                urlprx.urlretrieve(image_url, local_image_filename)

            try:
                print_image(section_cfg["x"], section_cfg["y"], local_image_filename, section_cfg["orientation"])
            except:
                print_image(section_cfg["x"], section_cfg["y"], local_image_filename)
        except urllib2.HTTPError, e:
            print("E: Could not download image:{0}. Got error code:{1}".format(image_url, e.code))
            exit_with_status('COULD_NOT_DOWNLOAD_XML_IMAGE')
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
        if len(image) != 0:
            image_params = image.split(",")
            if len(image_params) == 3:
                image_url = image_params[0]
                image_x = image_params[1]
                image_y = image_params[2]
                image_url_parts = urlparse.urlsplit(image_url)
                if len(image_url_parts) == 5:
                    #local_image_filename = section_cfg["local_image_folder"] + image_url_parts[2].replace("/", "_")
                    local_image_filename = path.join(get_main_dir(), "img", image_url_parts[2].replace("/", "_"))

                    if not path.isfile(local_image_filename):
                        try:
                            image_url = image_url.encode("utf-8")
                            local_image_filename = local_image_filename.encode("utf-8")
                            # use proxy class wrap to urllib to download image if proxy is set
                            if proxy == None:
                                ret = urllib.urlretrieve(image_url, local_image_filename)
                            else:
                                urlprx = UrllibProxy(proxy)
                                ret = urlprx.urlretrieve(image_url, local_image_filename)
                            print_image(image_x, image_y, local_image_filename)
                        except urllib2.HTTPError, e:
                            print("E: Could not download image:{0}. Got error code:{1}".format(image_url, e.code))
                            exit_with_status('COULD_NOT_DOWNLOAD_URL_IMAGE')
                    else:
                        print_image(image_x, image_y, local_image_filename)

#################################################################
def print_bar_2_of_5_value(section_cfg, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    try:
        set_section_font_indirect(section_cfg,"")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x"]), int(section_cfg["y"]), translate_to_2_of_5(value))
        set_section_font_indirect(section_cfg,"1")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x1"]), int(section_cfg["y1"]), translate_to_2_of_5(value))
        set_section_font_indirect(section_cfg,"2")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x2"]), int(section_cfg["y2"]), translate_to_2_of_5(value))
        set_section_font_indirect(section_cfg,"3")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x3"]), int(section_cfg["y3"]), translate_to_2_of_5(value))
    except(KeyError):
        pass
    except:
        exit_with_status('EXCEPTION_IN_2_OF_5')
        raise

#################################################################
def print_bar_3_of_9_value(section_cfg, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    try:
        set_section_font_indirect(section_cfg,"")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x"]), int(section_cfg["y"]), translate_to_3_of_9(value))
        set_section_font_indirect(section_cfg,"1")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x1"]), int(section_cfg["y1"]), translate_to_3_of_9(value))
        set_section_font_indirect(section_cfg,"2")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x2"]), int(section_cfg["y2"]), translate_to_3_of_9(value))
        set_section_font_indirect(section_cfg,"3")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x3"]), int(section_cfg["y3"]), translate_to_3_of_9(value))
    except(KeyError):
        pass
    except:
        exit_with_status('EXCEPTION_IN_3_OF_9')
        raise

#################################################################
def print_code128_value(section_cfg, value):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE
    try:
        set_section_font_indirect(section_cfg,"")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x"]), int(section_cfg["y"]), translate_to_code128(value))
        set_section_font_indirect(section_cfg,"1")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x1"]), int(section_cfg["y1"]), translate_to_code128(value))
        set_section_font_indirect(section_cfg,"2")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x2"]), int(section_cfg["y2"]), translate_to_code128(value))
        set_section_font_indirect(section_cfg,"3")
        DEVICE_CONTEXT.TextOut(int(section_cfg["x3"]), int(section_cfg["y3"]), translate_to_code128(value))
    except(KeyError):
        pass
    except:
        exit_with_status('EXCEPTION_IN_CODE128')
        raise

#################################################################
def print_static_text_value(cfg):
    for section in cfg.sections():
        try:
            if cfg.get(section, "type") == "static_text":
                text_value = cfg.get(section, "value")
                text_value = text_value.decode("windows-1257")
                text_value = text_value.encode("UTF-8")
                print_text_value(dict(cfg.items(section)), text_value)
            elif cfg.get(section, "type") == "image":
                print_image_value(dict(cfg.items(section)), cfg.get(section, "value"))
        except:
            print("no section type")

#################################################################
PLP_JSON_DATA = {}
LAYOUT = {}

def doPrint(plp_json_data):
    global DEVICE_CONTEXT
    global DEVICE_CONTEXT_HANDLE

    global PLP_JSON_DATA
    global LAYOUT

    PLP_JSON_DATA = plp_json_data
    BASEDIR = path.dirname(path.abspath(__file__))
    with open(path.join(BASEDIR, 'layout.yaml'), 'r') as layout_file:
        LAYOUT = loadYAML(layout_file)

    document_open = 0
    after_begin = False
    # cfg = ConfigParser.ConfigParser()
    layout_cfg = ConfigParser.ConfigParser()
    layout_cfg.read(path.join(BASEDIR,'layouts','_layouts_default.pla'))
    # layout_cfg = ConfigParser.ConfigParser().read('layouts\_layouts_default.pla')
    # we check for old jobs in printer queue when starting first document
    is_first_document = False
    for ticket in PLP_JSON_DATA['ticketData']['tickets']:
        print('ticket: {0}'.format(ticket))
        print("start new document")
        start_new_document(is_first_document)
        is_first_document = False
        document_open = 1

        print('layout_cfg: {0}'.format(layout_cfg))
        print('layout_cfg: {0}'.format(layout_cfg.sections()))

        for section_name in ticket:
            if layout_cfg.has_section(section_name):
                print('Printing section {0}'.format(section_name))
                param_val = ticket[section_name]
                if layout_cfg.get(section_name, "type") == "text":
                    print_text_value(dict(layout_cfg.items(section_name)), param_val)
                elif layout_cfg.get(section_name, "type") == "qmatrix":
                    print_qmatrix_value(dict(layout_cfg.items(section_name)), param_val)
                elif layout_cfg.get(section_name, "type") == "image_url":
                    print_image_url_value(dict(layout_cfg.items(section_name)), param_val)
                elif layout_cfg.get(section_name, "type") == "image_xml" and param_val != "":
                    print_image_xml_value(dict(layout_cfg.items(section_name)), param_val)
                elif layout_cfg.get(section_name, "type") == "bar_2_of_5":
                    print_bar_2_of_5_value(dict(layout_cfg.items(section_name)), param_val)
                    if layout_cfg.has_section("{0}_text".format(section_name)):
                        print_text_value(dict(layout_cfg.items("{0}_text".format(section_name))), param_val)
                elif layout_cfg.get(section_name, "type") == "bar_3_of_9":
                    print_bar_3_of_9_value(dict(layout_cfg.items(section_name)), param_val)
                    if layout_cfg.has_section("{0}_text".format(section_name)):
                        print_text_value(dict(layout_cfg.items("{0}_text".format(section_name))), param_val)
                elif layout_cfg.get(section_name, "type") == "bar_code128":
                    print_code128_value(dict(layout_cfg.items(section_name)), param_val)
                    if layout_cfg.has_section("{0}_text".format(section_name)):
                        print_text_value(dict(layout_cfg.items("{0}_text".format(section_name))), param_val)
                else:
                    print("unknown type for section:{0}".format(section_name))
                    exit_with_status('UNKNOWN_TYPE_FOR_SECTION')
            else:
                print('Missing section {0}'.format(section_name))

        return


        # elif param_key == "END":
        print_static_text_value(layout_cfg)
        print_document()
        document_open = 0
