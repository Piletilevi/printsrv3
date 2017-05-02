import                  win32ui
import                  win32gui
import                  win32print
from ctypes      import windll

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


    def __enter__(self):
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        print('__exit__ing')
        # del self.DEVICE_CONTEXT
        # del self.DEVICE_CONTEXT_HANDLE


    def setFont(self, name, w=None, h=None, weight=None, orientation=0):
        _log_font = [name]
        def callback(font, tm, fonttype, _font):
            if font.lfFaceName == _font[0]:
                _font[0]=font
            return True
        win32gui.EnumFontFamilies(self.DEVICE_CONTEXT_HANDLE, None, callback, _log_font)
        log_font = _log_font[0]
        log_font.lfWidth = int(w)
        log_font.lfHeight = int(h)
        log_font.lfWeight = int(weight)
        log_font.lfOrientation = int(orientation) * 10
        log_font.lfEscapement = int(orientation) * 10
        font_handle = win32gui.CreateFontIndirect(log_font)
        win32gui.SelectObject(self.DEVICE_CONTEXT_HANDLE, font_handle)


    def startDocument(self):
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

        # exit(0)


    def helloWorld(self):
        self.startDocument()
        text = u'Hello, WORLD!'
        self.setFont(name='Arial', w=12, h=30, weight=500, orientation=0)
        windll.gdi32.TextOutW( self.DEVICE_CONTEXT_HANDLE, 250, 250, text, len(text) )
        self.setFont(name='Arial', w=24, h=50, weight=1000, orientation=0)
        windll.gdi32.TextOutW( self.DEVICE_CONTEXT_HANDLE, 150, 150, text, len(text) )
        self.printDocument()


    def printDocument(self):
        self.DEVICE_CONTEXT.EndPage()
        self.DEVICE_CONTEXT.EndDoc()
