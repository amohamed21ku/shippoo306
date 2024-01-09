import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/models/Showingdata.dart';


import '../models/Sqldb.dart';


class employeescreen extends StatefulWidget {
  const employeescreen({super.key});

  @override
  State<employeescreen> createState() => _employeescreenState();
}

class _employeescreenState extends State<employeescreen>
     {
       Sqldb sqlDB = Sqldb();





  @override
  Widget build(BuildContext context)  {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Hero(
                tag: 'logo',
                child: Text(
                  'Shippo',
                  style: GoogleFonts.poppins(
                      color: Color(0xffF5E65F),
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Text(
                      'Employees',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600
                      )),
                  Row(children: [
                    RoundedButtonSmall(colour: Colors.yellow, title: 'Add', onPressed: (){Navigator.restorablePopAndPushNamed(context, 'addingEmployee');}, icon: Icons.add, width: 0, height: 0, iconColor: Colors.grey, textcolor: Colors.black,),
                  ],),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(30))),
                child:ShowingData()
              ),
            )
          ],
        ),
      
      
      
      
      
      
      ),
    );
  }
}
