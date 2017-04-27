# coding: utf-8
import win32print
import win32gui
import win32ui
from ctypes import windll

hprinter = win32print.OpenPrinter('Godex DT4x')
devmode = win32print.GetPrinter(hprinter, 2)["pDevMode"]
printjobs = win32print.EnumJobs(hprinter, 0, 999)
devmode.Orientation = 2

DEVICE_CONTEXT_HANDLE = win32gui.CreateDC("WINSPOOL", 'Godex DT4x', devmode)
DEVICE_CONTEXT = win32ui.CreateDCFromHandle(DEVICE_CONTEXT_HANDLE)
DEVICE_CONTEXT.SetMapMode(1)
print("DEVICE_CONTEXT.StartDoc")
DEVICE_CONTEXT.StartDoc("ticket.txt")
print("DEVICE_CONTEXT.StartPage")
DEVICE_CONTEXT.StartPage()
print("win32ui.CreateFont");
font = win32ui.CreateFont({"name": "Arial", "height": 16})
print("DEVICE_CONTEXT.SelectObject")
DEVICE_CONTEXT.SelectObject(font)

value = u'HAHAHAAA'

windll.gdi32.TextOutW( DEVICE_CONTEXT_HANDLE,
    835,
    386,
    value, len(value) )




DEVICE_CONTEXT.EndPage()
DEVICE_CONTEXT.EndDoc()
