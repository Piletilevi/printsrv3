﻿import System
from System import *
oo=Type.GetTypeFromProgID("POS.SA97")
bills=Activator.CreateInstance(oo)
bills.Init("COM3",57600,15)
bills.FCancel()
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("----------------------------------------------------")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("Text Text Text Text Text Text Text Text")
bills.Print("----------------------------------------------------")
bills.NFFinish()
bills.Close()