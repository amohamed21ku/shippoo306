import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/Screens/homescreen.dart';
import 'package:shippoo306/components.dart';

import '../models/User.dart';

class menuscreen extends StatelessWidget {

  static const routeName = 'menuscreen';

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
                    Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Orders', onPressed: () {  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => homescreen(),
                      ),
                    );
                    }, width: 10, height: 100,icon: Icons.local_shipping, iconColor: Colors.grey, textcolor: Colors.black,)),
                    SizedBox(width: 10,),
                    Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Customers', onPressed: () { Navigator.pushNamed(context, 'customerscreen'); }, width: 10, height: 100,icon: Icons.person, iconColor: Colors.grey, textcolor: Colors.black,)),
                  ],
                ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Employees', onPressed: () { Navigator.pushNamed(context, 'employeescreen' );}, width: 10, height: 100,icon: Icons.work, iconColor: Colors.grey, textcolor: Colors.black,)),
                      SizedBox(width: 10,),
                      Expanded(child: RoundedButtonSmall(colour: Colors.yellow, title: 'Drivers', onPressed: () {  Navigator.pushNamed(context, 'driverscreen'); }, width: 0, height: 100,icon: Icons.drive_eta, iconColor: Colors.grey, textcolor: Colors.black,)),
                
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
      RoundedButtonSmall(colour: Colors.yellow, title: 'Track Order', onPressed: () { Navigator.pushNamed(context, 'ordertrackingpage'); }, width: 0, height: 50,icon: Icons.numbers, iconColor: Colors.grey, textcolor: Colors.black,),
      RoundedButtonSmall(colour: Colors.yellow, title: 'Advanced Search', onPressed: () { Navigator.pushNamed(context, 'advancedsearch'); }, width: 0, height: 50,icon: Icons.search, iconColor: Colors.grey, textcolor: Colors.black,),
      RoundedButtonSmall(colour: Colors.yellow, title: 'Random Data', onPressed: () { Navigator.pushNamed(context, 'queryscreen'); }, width: 0, height: 50,icon: Icons.book, iconColor: Colors.grey, textcolor: Colors.black,),






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
