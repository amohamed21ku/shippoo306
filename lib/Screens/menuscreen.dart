import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';

import '../models/User.dart';

class menuscreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
        SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25,top: 25),
        child: Column( mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Padding(
            padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
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
          ],
        ),
            ),
              SizedBox(height: 50,),
              Expanded(
                child: Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                  Text(
                  'Welcome ${User.currentuser.Firstname}',
                  style: GoogleFonts.poppins(
                      fontSize: 16.0,
                )),
                  SizedBox(height: 20,),
                  Row(
                  children: [
                    Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Orders', onPressed: () {Navigator.pushNamed(context, 'homescreen');
                    }, width: 10, height: 100,icon: Icons.local_shipping, iconColor: Colors.grey, textcolor: Colors.black,)),
                    SizedBox(width: 10,),
                    Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Customers', onPressed: () {  }, width: 10, height: 100,icon: Icons.person, iconColor: Colors.grey, textcolor: Colors.black,)),
                  ],
                ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Employees', onPressed: () { Navigator.pushNamed(context, 'employeescreen' );}, width: 10, height: 100,icon: Icons.work, iconColor: Colors.grey, textcolor: Colors.black,)),
                      SizedBox(width: 10,),
                      Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Drivers', onPressed: () {  }, width: 0, height: 100,icon: Icons.drive_eta, iconColor: Colors.grey, textcolor: Colors.black,)),
                
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
Expanded(
  child: Column(
    children: [
      RoundedButtonSmall(colour: Colors.yellow, title: 'Track Order', onPressed: () {  }, width: 0, height: 50,icon: Icons.add_box, iconColor: Colors.grey, textcolor: Colors.black,),






    ],
  ),
)
                
                
                    ],)]),
              )
            ]
        ),
      )
        )
    ]));
  }
}
