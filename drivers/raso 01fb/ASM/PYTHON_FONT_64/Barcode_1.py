import System
from System import *
oo=Type.GetTypeFromProgID("POS.SA97")
bills=Activator.CreateInstance(oo)
bills.Init("COM3",57600,15)
bills.FCancel()
bills.Print("Barcode EAN13")
#Barcode characters print position
bills.SendEsc("1D4802")
#Barcode characters font
bills.SendEsc("1D6601")
#Barcode height
bills.SendEsc("1D6860")
#Barcode horizontal size
bills.SendEsc("1D7704")
#Barcode printing position
bills.SendEsc("1B6100")
#Print barcode
bills.SendEsc("1D6B0231323334353637383930313200")
bills.Print("  ")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("  ")
bills.NFFinish()
bills.Close()
bills.Init("COM3",57600,15)
bills.FCancel()
bills.Print("Barcode EAN13")
#Barcode characters print position
bills.SendEsc("1D4802")
#Barcode characters font
bills.SendEsc("1D6601")
#Barcode height
bills.SendEsc("1D6860")
#Barcode horizontal size
bills.SendEsc("1D7704")
#Barcode printing position
bills.SendEsc("1B6100")
#Print barcode
bills.SendEsc("1D6B0231323334353637383930313200")
bills.Print("  ")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("  ")
bills.NFFinish()
bills.Close()
bills.Init("COM3",57600,15)
bills.FCancel()
bills.Print("Barcode EAN13")
#Barcode characters print position
bills.SendEsc("1D4802")
#Barcode characters font
bills.SendEsc("1D6601")
#Barcode height
bills.SendEsc("1D6860")
#Barcode horizontal size
bills.SendEsc("1D7704")
#Barcode printing position
bills.SendEsc("1B6100")
#Print barcode
bills.SendEsc("1D6B0231323334353637383930313200")
bills.Print("  ")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("  ")
bills.NFFinish()
bills.Close()
bills.Init("COM3",57600,15)
bills.FCancel()
bills.Print("Barcode EAN13")
#Barcode characters print position
bills.SendEsc("1D4802")
#Barcode characters font
bills.SendEsc("1D6601")
#Barcode height
bills.SendEsc("1D6860")
#Barcode horizontal size
bills.SendEsc("1D7704")
#Barcode printing position
bills.SendEsc("1B6100")
#Print barcode
bills.SendEsc("1D6B0231323334353637383930313200")
bills.Print("  ")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("  ")
bills.NFFinish()
bills.Close()
