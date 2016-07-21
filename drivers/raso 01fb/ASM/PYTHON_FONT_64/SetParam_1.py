import System
from System import *
oo=Type.GetTypeFromProgID("POS.SA97")
bills=Activator.CreateInstance(oo)
bills.Init("COM3",57600,15)
bills.FCancel()
#bills.VPassword("000000")
#----------------------------------------------------------------------------
bills.SetParameter(17,"Header4")
bills.SetParameter(18,"Header5")
bills.SetParameter(19,"Header6")
#----------------------------------------------------------------------------
bills.SetParameter(20,"Info1 ........")
bills.SetParameter(21,"Info2 ........")
bills.SetParameter(22,"Info3 ........")
bills.SetParameter(23,"Info4 ........")
#----------------------------------------------------------------------------
bills.FCancel()
bills.FStart(0)
bills.Print("TEST...........")
bills.FFinish3("KREDITAS1",0,1,"KREDITAS2",0,2,"GRYNIEJI",2,0)
bills.Close()
