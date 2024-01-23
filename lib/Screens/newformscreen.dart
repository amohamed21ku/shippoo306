
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';

import '../models/Sqldb.dart';

class newformscreen extends StatefulWidget {
  newformscreen({super.key});

  @override
  State<newformscreen> createState() => _newformscreenState();
}

class _newformscreenState extends State<newformscreen> {
  late double Weight;
  late String Type;
  late String Description;

  int? selectedvalue;
  late int  SenderId ;

  late int RecieverId ;

  String SenderLoc ='';

  String RecieverLoc ='';

  int DriverId = 0 ;


  String ShipmentDate = '';

  String DeliveryDate = '';

  String Status = 'InProcess';

  final Sqldb sqlDB = Sqldb();

  int myselc =0;

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
                    SenderId = int.parse(value);
                  }, h: 40,)),

                ],
              ),


              SizedBox(
                height: 10,
              ),


              MY_textField(hint_text: ' Location', onchange: (value){SenderLoc = value;}, h: 40,),
              SizedBox(
                height: 10,
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
                  Expanded(child: MY_textField(hint_text: "Customer Id", onchange: (value){
                    RecieverId = int.parse(value);
                  }, h: 40,)),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              MY_textField(hint_text: "Location", onchange: (value){RecieverLoc = value;}, h: 40,),
              SizedBox(height: 25,),
              Column(
                children: [
                  Row(children: [
                    Expanded(child: MY_DropdownButton(hint_text: 'Driver ID',  onChanged: (value) {  setState(() {
                      selectedvalue = value;
                      DriverId = value??0;

                    });print(DriverId);}, h: 40, sql: '''SELECT * FROM Driver WHERE Status = 'Available';''', yourColumnName: 'DriverId',selectedValue: selectedvalue,)),
                    SizedBox(width: 20,),
                    Expanded(
                      child: DropdownButton(
                        hint: Text('Status'),
                        value: Status,
                        items: ['InProcess', 'Delivered', 'Canceled'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            Status = value?? '';

                          });
                        },
                      ),
                    )
                  ],),
                  SizedBox(height: 15,),
                  Row(children: [
                    Expanded(child: MY_textField(hint_text: "Shipment Date", onchange: (value){
                      ShipmentDate = value;}, h: 40,)),
                    SizedBox(width: 20,),
                    Expanded(child: MY_textField(hint_text: "Delivery Date", onchange: (value){
                      DeliveryDate = value;}, h: 40,)),
                  ],)
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Divider(
                color: Colors.white,
                thickness: 2,
                height: 30,
              ),
              Column(children: [
                Text(
                  'Cargo',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15,),
                Row(children: [
                  Expanded(child: MY_textField(hint_text: "Weight", onchange: (value){
                    Weight = double.parse(value);
                  }, h: 40,)),
                  SizedBox(width: 20,),
                  Expanded(child: MY_textField(hint_text: "Type", onchange: (value){
                    Type = value;
                    }, h: 40,)),
                ],),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Expanded(child:MY_textField(hint_text: 'Description',  h: 50, onchange: (value) { Description = value;}))

                  ],
                ),


              ],),
              SizedBox(height: 20,),

              RoundedButton2(
                colour: Colors.yellow,
                title: "Sumbit",
                onPressed: () {
                  sqlDB.insertData('''
            INSERT INTO Orders (SenderId, SenderLoc, ReceiverId, ReceiverLoc, DriverId, Status, ShipmentDate, DeliveryDate)
                  VALUES
                     ($SenderId, '$SenderLoc',$RecieverId,'$RecieverLoc', $DriverId, '$Status', '$ShipmentDate', '$DeliveryDate');
                  ''');

            //
                  sqlDB.insertData('''
            INSERT INTO Cargo (Description, Weight, Type)
                  VALUES
                     ($Description, $Weight,$Type);
                  ''');
                  sqlDB.updateDriverStatus();
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
