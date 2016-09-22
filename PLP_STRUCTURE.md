# PLP - PiletiLevi Printing

Two types of PLP files are supported

## PLP with fiscal data

**Example**

    {
        "info": "fiscal",
        "printer": {
            "name": "COM4",
            "type": "fiscal"
        },
        "operation": "sale",
        "salesPoint": "* Bilietai BO",
        "payments": [
            {
                "type": "3",
                "cost": 10.00,
                "components": [
                    {
                        "type": "tickets",
                        "name": "Bilietai",
                        "cost": 1.60,
                        "kkm": true,
                        "vatPerc": 0.00
                    }, {
                        "type": "service fee",
                        "amount": 8,
                        "name": "Test mokestis BT",
                        "cost": 7.20,
                        "kkm": true,
                        "vatPerc": 20
                    }, {
                        "type": "service fee",
                        "amount": 8,
                        "name": "Pardavimo punkto mokestis",
                        "cost": 1.20,
                        "kkm": true,
                        "vatPerc": 20
                    }
                ]
            }, {
                "type": "1",
                "cost": 3.60,
                "components": [
                    {
                        "type": "service fee",
                        "amount": 8,
                        "name": "Pardavimo punkto mokestis",
                        "cost": 3.60,
                        "kkm": true,
                        "vatPerc": 20
                    }
                ]
            }
        ]
    }

## PLP with ticket information
**Example**

    {
        "info": "fiscal",
        "printer": {
            "name": "COM4",
            "type": "fiscal"
        },
        "operation": "sale",
        "salesPoint": "* Bilietai BO",
        "payments": [
            {
                "type": "3",
                "cost": 10.00,
                "components": [
                    {
                        "type": "tickets",
                        "name": "Bilietai",
                        "cost": 1.60,
                        "kkm": true,
                        "vatPerc": 0.00
                    }, {
                        "type": "service fee",
                        "amount": 8,
                        "name": "Test mokestis BT",
                        "cost": 7.20,
                        "kkm": true,
                        "vatPerc": 20
                    }, {
                        "type": "service fee",
                        "amount": 8,
                        "name": "Pardavimo punkto mokestis",
                        "cost": 1.20,
                        "kkm": true,
                        "vatPerc": 20
                    }
                ]
            }, {
                "type": "1",
                "cost": 3.60,
                "components": [
                    {
                        "type": "service fee",
                        "amount": 8,
                        "name": "Pardavimo punkto mokestis",
                        "cost": 3.60,
                        "kkm": true,
                        "vatPerc": 20
                    }
                ]
            }
        ]
    }
