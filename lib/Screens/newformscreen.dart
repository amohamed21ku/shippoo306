import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';

class newformscreen extends StatelessWidget {
   newformscreen({super.key});

  int SenderId = 0;
  int RecieverId = 0;
  String SenderLoc ='';
  String RecieverLoc ='';
  int DriverId = 0;
  int VechicleId=0;
  String ShipmentDate = '';
  String DeliveryDate = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242422),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Ensure children take the full width
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 130, right: 130),
                child: Container(
                  height: 4,
                  color: Colors.white24,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'New Order',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Send From',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(child: MY_textField(hint_text: "Customer ID", onchange: (value){
                    SenderId = value;
                  }, h: 40,)),
                  SizedBox(width: 20),
                  // Expanded(child: MY_textField(hint_text: "Date", onchange: null,)),
                ],
              ),


              SizedBox(
                height: 10,
              ),
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MY_textField(hint_text: '', onchange: null, h: 100,),
              SizedBox(
                height: 25,
              ),
              Text(
                'Send To',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: MY_textField(hint_text: "Customer Id", onchange: null, h: 40,)),
                ],
              ),

              // Row(
              //   children: [
              //     Expanded(child: MY_textField(hint_text: "Email", onchange: null,)),
              //     SizedBox(width: 20),
              //     Expanded(child: MY_textField(hint_text: "Phone Number", onchange: null,)),
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              MY_textField(hint_text: "", onchange: null, h: 100,),
              SizedBox(height: 25,),
              Column(
                children: [
                  Row(children: [
                    Expanded(child: MY_textField(hint_text: "Driver Id", onchange: null, h: 40,)),
                    SizedBox(width: 20,),
                    Expanded(child: MY_textField(hint_text: "Vechicle Id", onchange: null, h: 40,)),
                  ],),
                  SizedBox(height: 15,),
                  Row(children: [
                    Expanded(child: MY_textField(hint_text: "Shipment Date", onchange: null, h: 40,)),
                    SizedBox(width: 20,),
                    Expanded(child: MY_textField(hint_text: "Delivery Date", onchange: null, h: 40,)),
                  ],)
                ],
              ),
              RoundedButton2(
                colour: Colors.yellow,
                title: "Sumbit",
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, 'homescreen');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
