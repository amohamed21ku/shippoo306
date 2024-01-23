import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/Screens/homecontent.dart';
import 'package:shippoo306/Screens/newformscreen.dart';

import '../models/Details.dart';



class InprocessScreen extends StatefulWidget {
  const InprocessScreen({super.key});

  @override
  State<InprocessScreen> createState() => _InprocessScreenState();
}

class _InprocessScreenState extends State<InprocessScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  late Animation animation3;
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    animation = ColorTween(begin: Colors.black45, end: Colors.black)
        .animate(controller);

    animation2 = ColorTween(begin: Colors.black45, end: Colors.yellow)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget build_bottomsheet(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            body: newformscreen(),
          ));
    }

    Details details = Details(activeButton: 1);
    return Scaffold(
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
          SizedBox(
            height: 19,
          ),
          ButtonRow(index: 1,),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(30))),
              child:details.choosing_details(),
            ),
          )
        ],
      ),







      // Bottom Bar ======================================================================================
      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () {
          //code to execute on button press
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: build_bottomsheet);
        },
        backgroundColor: Color(0xffF5E65F),
        child: Icon(Icons.add,color: Colors.black,size: 30,),

        //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:  BottomAppBar(
        height: 100,
        color: Color(0xff1D1F24),
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myiconbutton(icon: Icons.home, title: 'home',onPressed: (){
              Navigator.popAndPushNamed(context, 'menuscreen');
            } , color: Colors.white), // error is here
            myiconbutton(icon: Icons.person, title: 'Profile' , onPressed: (){
              Navigator.pushNamed(context, 'profilepage');
            } , color: Colors.white), // and here at onPressed: () {} onPressed: () {}
          ],
        ),
      ),
    );
  }
}
