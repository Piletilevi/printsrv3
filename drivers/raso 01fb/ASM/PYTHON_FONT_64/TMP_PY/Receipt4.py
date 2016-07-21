import System
from System import *
oo=Type.GetTypeFromProgID("POS.SA97")
bills=Activator.CreateInstance(oo)
bills.Init("COM3",57600,15)
bills.FCancel()
bills.FStart(0)
bills.SendEsc("1B2121") # Horizintal FontB
bills.Print("INFORMACIJA APIE PREKĘ")
bills.FOperation("123456789012 (5x10)",1,100,0)
bills.SendEsc("1B2101")
bills.Print("             Garantinės sąlygos:")
bills.Print("12345678901234567890123456789012345678901234567")
bills.Print("Textas Textas Textas Textas Textas Textas Texts")
bills.Print("Textas Textas Textas Textas Textas Textas Texts")
bills.Print("Textas Textas Textas Textas Textas Textas Texts")
bills.Print("Textas Textas Textas Textas Textas Textas Texts")
bills.Print("Textas Textas Textas Textas Textas Textas Texts")
bills.SendEsc("1B2111") # Vertikaliai FontB
bills.FFinish3("KREDITAS1",0,1,"KREDITAS2",0,2,"GRYNIEJI",110,0)
bills.Close()
