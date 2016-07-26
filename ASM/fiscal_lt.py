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
print(json.dumps(plp_json_data, indent=4, sort_keys=False))
print("\n\n")

oo = Type.GetTypeFromProgID("POS.SA97")
bills = Activator.CreateInstance(oo)
bills.Init()
bills.FCancel()
bills.FStart(0)
bills.Print("")
bills.Print("{0} - {1}".format(plp_json_data["salesPoint"], plp_json_data["operation"]))
bills.Print("")

payment_methods = {1:0, 2:0, 3:0, 4:0}
for payment in plp_json_data["payments"]:
    payment_methods[payment["type"]] += payment["cost"]
    for component in payment["components"]:
        if (not component["kkm"]):
            continue
        bills.Print("{0}:{1}{2}{3}".format(
            payment["type"],
            " %s" % component["type"] if component["type"] else "",
            " %s" % component["name"] if component["name"] else "",
            " x %s" % component["amount"] if component["amount"] else ""
        ))
        component["amount"] = 1
        vat_sign = 0 if component["type"] == "service fee" else 3
        bills.FOperation(component["name"], component["amount"], component["cost"], vat_sign)

# bills.Print( "Nr. Prekė          ")
# bills.FOperation("1. Bilietas      ",1,20.0,0)
# bills.Print("----------------------------------------------------")
# bills.FOperation("Mokestis",1,3.0,0)
# bills.FOperation("Kasos extra",1,1.0,0)
# bills.Print("----------------------------------------------------")
bills.FFinish3(
    "Gift card", payment_methods[1], 1,
    "Cache", payment_methods[3], 0,
    "GRYNIEJI", payment_methods[3], 0)
bills.Close()
