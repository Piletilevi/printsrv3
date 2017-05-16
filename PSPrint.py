# This Python file uses the following encoding: utf-8

# PSPrint module
import                                    win32ui
import                                    win32gui
import                                    win32print
import                                    sys
import                                    math
from os           import                  chdir
from os           import path          as path
from ctypes       import                  windll
from yaml         import load          as loadYAML
from code128image import code128_image as _c128image
from PIL          import                  ImageWin
from PIL          import                  Image

class PSPrint:
    def __init__(self, feedback, bye, plp_json_data):
        self.feedback      = feedback
        self.bye           = bye
        self.PLP_JSON_DATA = plp_json_data
        if hasattr(sys, "frozen"):
            self.BASEDIR = path.dirname(sys.executable)
        else:
            self.BASEDIR = path.dirname(__file__)
        chdir(self.BASEDIR)

        printer = self.PLP_JSON_DATA['ticketData']['printerData']['printerName']
        try:
            hprinter = win32print.OpenPrinter(printer)
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        try:
            devmode = win32print.GetPrinter(hprinter, 2)['pDevMode']
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        try:
            devmode.Orientation = 2
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        printjobs = win32print.EnumJobs(hprinter, 0, 999)
        while len(printjobs) != 0:
            ret = windll.user32.MessageBoxW(0, 'Printer has old jobs in queue'.decode(), 'Check printer!'.decode(), 0x40 | 0x0) #OK only
            printjobs = win32print.EnumJobs(hprinter, 0, 999)

        try:
            self.DEVICE_CONTEXT_HANDLE = win32gui.CreateDC('WINSPOOL', printer, devmode)
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        try:
            self.DEVICE_CONTEXT = win32ui.CreateDCFromHandle(self.DEVICE_CONTEXT_HANDLE)
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        layout_fn = path.join(self.BASEDIR, 'config', 'layout.yaml')
        with open(layout_fn, 'r', encoding='utf-8') as layout_file:
            self.PS_LAYOUT = loadYAML(layout_file)


    def __enter__(self):
        print('Enter PSPrint')
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        print('Exit PSPrint')


    def _setFont(self, font_name, w=None, h=None, weight=None, orientation=0):
        if font_name is not None:
            _log_font = [font_name]
            def callback(font, tm, fonttype, _font):
                if font.lfFaceName == _font[0]:
                    _font[0]=font
                return True
            win32gui.EnumFontFamilies(self.DEVICE_CONTEXT_HANDLE, None, callback, _log_font)
            self.log_font = _log_font[0]

        self.log_font.lfWidth = int(w)
        self.log_font.lfHeight = int(h)
        self.log_font.lfWeight = int(weight)
        self.log_font.lfOrientation = int(orientation) * 10
        self.log_font.lfEscapement = int(orientation) * 10
        font_handle = win32gui.CreateFontIndirect(self.log_font)
        win32gui.SelectObject(self.DEVICE_CONTEXT_HANDLE, font_handle)


    def _placeText(self, x, y, text):
        windll.gdi32.TextOutW(self.DEVICE_CONTEXT_HANDLE, x, y, text, len(text))


    def _placeImage(self, x, y, url, rotate):
        rotate = math.floor((rotate%360)/90+0.5)
        _picture_fn = '{0}_{1}.png'.format(path.join(self.BASEDIR, 'img', path.basename(url)), rotate)
        print('url: ', url)
        print('_picture_fn: ', _picture_fn)
        if not os.path.isfile(_picture_fn):
            try:
                r = requests.get(url, verify=False)
                r.raise_for_status()
            except requests.exceptions.HTTPError as err:
                print('1', err)
                return
            except requests.exceptions.Timeout as err:
                print('2', err)
                return
            except requests.exceptions.TooManyRedirects as err:
                print('3', err)
                return
            except requests.exceptions.RequestException as err:
                # catastrophic error. bail.
                print('4', err)
                return

            with open(_picture_fn, 'wb') as fd:
                print('with ', _picture_fn)
                for chunk in r.iter_content(chunk_size=128):
                    fd.write(chunk)
            _picture = Image.open(_picture_fn)
            if rotate:
                print('rotating: ', rotate*90)
                _picture = _picture.transpose((rotate-1)%3 + 2)

            print('save')
            _picture.save(_picture_fn, 'PNG')

        _picture = Image.open(_picture_fn)
        dib = ImageWin.Dib(_picture)
        x = int(x)
        y = int(y)
        dib.draw(self.DEVICE_CONTEXT_HANDLE, (x, y, x + _picture.size[0], y + _picture.size[1]))


    def _placeC128(self, text, x, y, width, height, thickness, rotate, quietzone):
        rotate = math.floor((rotate%360)/90+0.5)
        print('Placing {0}, x:{1}, y:{2}, w:{3}, h:{4}'.format(text, x, y, width, height))
        file1 = '{0}_1_{1}.png'.format(path.join(self.BASEDIR, 'img', 'tmp'), rotate)
        file2 = '{0}_2_{1}.png'.format(path.join(self.BASEDIR, 'img', 'tmp'), rotate)
        _picture = _c128image(text, int(width), int(height), quietzone)
        print('dimensions of {0}: {1}'.format(file1, _picture.size))
        _picture.save(file1, 'JPEG')
        _picture = Image.open(file1)
        print('dimensions of {0}: {1}'.format(file1, _picture.size))
        if rotate:
            print('rotating: ', rotate*90)
            _picture = _picture.transpose((rotate-1)%3 + 2)
            print('dimensions of {0}: {1}'.format(file2, _picture.size))
        _picture.save(file2, 'png')
        _picture = Image.open(file2)
        print('dimensions of {0}: {1}'.format(file2, _picture.size))
        dib = ImageWin.Dib(_picture)
        x = int(x)
        y = int(y)
        dib.draw(self.DEVICE_CONTEXT_HANDLE, (x, y, x + _picture.size[0], y + _picture.size[1]))
        print('dimensions: {0}'.format(_picture))


    def _startDocument(self):
        # print("DEVICE_CONTEXT.SetMapMode")
        self.DEVICE_CONTEXT.SetMapMode(1)
        # print("DEVICE_CONTEXT.StartDoc")
        self.DEVICE_CONTEXT.StartDoc("ticket.txt")
        # print("DEVICE_CONTEXT.StartPage")
        self.DEVICE_CONTEXT.StartPage()
        # print("win32ui.CreateFont");
        font = win32ui.CreateFont({"name": "Arial", "height": 16})
        # print("DEVICE_CONTEXT.SelectObject")
        self.DEVICE_CONTEXT.SelectObject(font)
        # print("DEVICE_CONTEXT.SelectObject DONE")


    def _printDocument(self):
        self.DEVICE_CONTEXT.EndPage()
        self.DEVICE_CONTEXT.EndDoc()


    def printTickets(self):
        for ticket in self.PLP_JSON_DATA['ticketData']['tickets']:
            self._startDocument()
            self.printTicket(ticket)
            self._printDocument()


    def _getInstanceProperty(self, key, instance, field, mandatory=False):
        if key in instance:
            return instance.get(key)
        if key in field.get('common', []):
            return field.get('common').get(key)
        if mandatory:
            print('Text without {0} - {1}'.format(key, field))
        return None


    def printTicket(self, ticket):
        # print('ticket : {0}'.format(ticket.keys()))
        for layout_key in self.PS_LAYOUT.keys():
            # print('layout_key : {0}'.format(layout_key))
            # print('{0} : {1}'.format(key,field))
            field = self.PS_LAYOUT[layout_key]
            value = ticket.get(layout_key, self.PLP_JSON_DATA.get(layout_key, ''))
            if value == '':
                print('skip {0}'.format(layout_key))
                continue

            if field['type'] == 'text':
                for instance in field['instances']:
                    font_name   = self._getInstanceProperty('font_name', instance, field)
                    font_height = self._getInstanceProperty('font_height', instance, field)
                    font_width  = self._getInstanceProperty('font_width', instance, field)
                    font_weight = self._getInstanceProperty('font_weight', instance, field)
                    x           = self._getInstanceProperty('x', instance, field)
                    y           = self._getInstanceProperty('y', instance, field)
                    if not (font_height and font_width and font_weight and x and y):
                        continue
                    orientation = self._getInstanceProperty('orientation', instance, field) or 0
                    prefix      = self._getInstanceProperty('prefix', instance, field) or ''
                    suffix      = self._getInstanceProperty('suffix', instance, field) or ''
                    self._setFont(font_name, font_width, font_height, font_weight, orientation)
                    # print('Placing {0}, {1}, {2}{3}{4}'.format(x, y, prefix, value, suffix))
                    self._placeText(x, y, '{0}{1}{2}'.format(prefix, value, suffix))
                continue

            elif field['type'] == 'image':
                for instance in field['instances']:
                    self._placeImage(x, y, value, orientation)
                continue

            elif field['type'] == 'code128':
                for instance in field['instances']:
                    thickness   = self._getInstanceProperty('thickness', instance, field)       or 10
                    width       = self._getInstanceProperty('width', instance, field)           or 560
                    height      = self._getInstanceProperty('height', instance, field)          or 100
                    x           = instance.get('x', field.get('common', {'x': False}).get('x', False))
                    y           = instance.get('y', field.get('common', {'y': False}).get('y', False))
                    # orientation = instance.get('orientation', field.get('common', {'orientation': 0}).get('orientation', 0))
                    orientation = self._getInstanceProperty('orientation', instance, field)     or 0
                    quietzone   = self._getInstanceProperty('quietzone', instance, field)       or False
                    if not (x and y):
                        continue
                    print('Placing {0}, x:{1}, y:{2}, w:{3}, h:{4}'.format(value, x, y, width, height))
                    self._placeC128(value, x, y, width, height, thickness, orientation, quietzone)
                continue
