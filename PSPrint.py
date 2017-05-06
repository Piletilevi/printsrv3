import                                    win32ui
import                                    win32gui
import                                    win32print
from ctypes       import                  windll
from yaml         import load          as loadYAML
from code128image import code128_image as _c128image
from PIL          import ImageWin, Image

class PSPrint:
    def __init__(self, plp_json_data):
        self.PLP_JSON_DATA = plp_json_data

        printer = self.PLP_JSON_DATA['ticketData']['printerData']['printerName']
        try:
            hprinter = win32print.OpenPrinter(printer)
        except:
            print("E: exception while opening printer")
            raise e

        try:
            devmode = win32print.GetPrinter(hprinter, 2)["pDevMode"]
        except Exception as e:
            print("E: exception while opening devmode")
            raise e

        try:
            devmode.Orientation = 2
        except:
            print("Setting orientation failed: {0}".format(sys.exc_info()[0]))

        printjobs = win32print.EnumJobs(hprinter, 0, 999)
        while len(printjobs) != 0:
            ret = windll.user32.MessageBoxW(0, "Printer has old jobs in queue".decode(), "Check printer!".decode(), 0x40 | 0x0) #OK only
            printjobs = win32print.EnumJobs(hprinter, 0, 999)

        try:
            self.DEVICE_CONTEXT_HANDLE = win32gui.CreateDC("WINSPOOL", printer, devmode)
        except Exception as e:
            print("E: exception while creating DEVICE_CONTEXT_HANDLE")
            raise e

        try:
            self.DEVICE_CONTEXT = win32ui.CreateDCFromHandle(self.DEVICE_CONTEXT_HANDLE)
        except Exception as e:
            print("E: exception while creating DEVICE_CONTEXT")
            raise e

        with open('layout.yaml', 'r', encoding='utf-8') as layout_file:
            self.PS_LAYOUT = loadYAML(layout_file)


    def __enter__(self):
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        print('__exit__ing')


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


    def _placeImage(self, x, y, url):
        windll.gdi32.TextOutW(self.DEVICE_CONTEXT_HANDLE, x, y, url, len(url))


    def _placeC128(self, text, x, y, width, height, thickness, rotate, quietzone):
        bmp = _c128image(text, int(width), int(height), quietzone)
        bmp.save('tmp1.jpeg', 'JPEG')
        bmp = Image.open('tmp1.jpeg')
        bmp = bmp.rotate(rotate)
        bmp.save('tmp2.jpeg', 'JPEG')
        bmp = Image.open('tmp2.jpeg')
        dib = ImageWin.Dib(bmp)
        x = int(x)
        y = int(y)
        dib.draw(self.DEVICE_CONTEXT_HANDLE, (x, y, x + bmp.size[0], y + bmp.size[1]))
        print('dimensions: {0}'.format((x, y, x + bmp.size[0], y + bmp.size[1])))
        # exit(0)


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


    def printTickets(self, tickets):
        for ticket in tickets:
            self._startDocument()
            self.printTicket(ticket)
            self._printDocument()


    def _getInstanceProperty(self, key, instance, field, mandatory=False):
        if key in instance:
            return instance[key]
        if key in field:
            return field[key]
        if mandatory:
            print('Text without {0} - {1}'.format(key, field))
        return None


    def printTicket(self, ticket):
        # print('ticket : {0}'.format(ticket.keys()))
        for layout_key in self.PS_LAYOUT.keys():
            # print('layout_key : {0}'.format(layout_key))
            # print('{0} : {1}'.format(key,field))
            if layout_key not in ticket.keys():
                print('{0} not in {1}\n'.format(layout_key, ticket.keys()))
                continue
            field = self.PS_LAYOUT[layout_key]
            value = ticket[layout_key]
            # print('{0}: {1}, field:{2}'.format(layout_key, value, field))
            if value == '':
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
                    prefix = self._getInstanceProperty('prefix', instance, field) or ''
                    suffix = self._getInstanceProperty('suffix', instance, field) or ''
                    self._setFont(font_name, font_width, font_height, font_weight, orientation=0)
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
                    x           = self._getInstanceProperty('x', instance, field)
                    y           = self._getInstanceProperty('y', instance, field)
                    orientation = self._getInstanceProperty('orientation', instance, field)     or 0
                    quietzone   = self._getInstanceProperty('quietzone', instance, field)       or False
                    if not (x and y):
                        continue
                    self._placeC128(value, x, y, width, height, thickness, orientation, quietzone)
                continue


    def helloWorld(self):
        self._startDocument()
        text = u'Hello, WORLD!'
        self._setFont(font_name='Arial', w=12, h=30, weight=500, orientation=0)
        self._placeText(250, 250, text)
        self._setFont(font_name='Arial', w=24, h=50, weight=1000, orientation=0)
        self._placeText(150, 150, text)
        # self._placeC128('650', '6', '3', '100', '1234567890123456', 90)
        self._printDocument()
