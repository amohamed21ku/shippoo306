import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/Screens/homecontent.dart';
import 'package:shippoo306/Screens/newformscreen.dart';
import 'package:shippoo306/models/Showingdata.dart';
import 'package:shippoo306/widgets/infolist.dart';


class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen>
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
          ButtonRow(),
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
              child: ShowingData(),
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
            myiconbutton(icon: Icons.home, title: 'home',onPressed: (){} , color: Colors.white), // error is here
            myiconbutton(icon: Icons.person, title: 'Profile' , onPressed: (){} , color: Colors.white), // and here at onPressed: () {}
          ],
        ),
      ),
    );
  }
}
