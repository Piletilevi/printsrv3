# coding: utf-8

import json
import os
import System
from System import *

plp_filename = os.environ["plp_filename"]

with open(plp_filename, "rU") as plp_data_file:
    plp_json_data = json.load(plp_data_file)

plp_file_type = plp_json_data["info"]

print("{0} type: {1}\n".format(plp_filename, plp_file_type))
print(plp_json_data)
exit()

oo=Type.GetTypeFromProgID("POS.SA97")
bills=Activator.CreateInstance(oo)
bills.Init("COM5",57600,15)
bills.FCancel()
bills.FStart(0)
bills.Print(" ")
bills.Print("Renginys:  RESTA 2015")
bills.Print(" ")
bills.Print("         Jūsų bilieto barkodas")
bills.Print(" ")
#Barcode characters print position
bills.SendEsc("1D4802")
#Barcode characters font
bills.SendEsc("1D6600")
#Barcode height
bills.SendEsc("1D6860")
#Barcode horizontal size
bills.SendEsc("1D7702")
#Barcode printing position
bills.SendEsc("1B6101")
#Print barcode
#bills.SendEsc("1D6B49117B4250345A4C30303030303038393030303235")
#bills.SendEsc("1D6B49313233024C616261206469656E6100")
#bills.SendEsc("1D6B49117B424C616261206469656E6100")
#bills.SendEsc("1D6B49117B420250345A4C30303030303038393030303235")
#bills.SendEsc("1D6B49117B4250414141")
#bills.SendEsc("1D6B49077B427B430C2238")
#bills.SendEsc("1D6B490A7B4231323334353637383930")
#bills.SendEsc("1D6B04303131323334353637383930313200")
#bills.SendEsc("1D6B49127B4230313132333435363738393031323937")
bills.SendEsc("1D6B490C7B4231323334353637383930")
bills.Print("")
bills.Print( "Nr. Prekė          ")
bills.FOperation("1. Bilietas      ",1,20.0,0)
bills.Print("----------------------------------------------------")
bills.FOperation("Mokestis",1,3.0,0)
bills.FOperation("Kasos extra",1,1.0,0)
bills.Print("----------------------------------------------------")
bills.FFinish3("KREDITAS1",0,1,"KREDITAS2",0,2,"GRYNIEJI",200,0)
bills.Close()
