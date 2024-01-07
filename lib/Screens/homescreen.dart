import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/screens/NewformScreen.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/widgets/InfoList.dart';

import '../widgets/InfoCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
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
              child: InfoList(
                info: [
                  infoCard(
                    name: 'Fares Matar',
                    Date: '13/7/2023',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: '',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                  infoCard(
                    name: 'Abdelrahman Mohamed',
                    Date: '12/8/2020',
                    onpress: null,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
        child: Icon(Icons.add,color: Colors.white,size: 30,),

        //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff1D1F24),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    'Home',
                    style: GoogleFonts.poppins(fontSize: 14),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, bottom: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "profilepage");
                    },
                  ),
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins(fontSize: 14),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
