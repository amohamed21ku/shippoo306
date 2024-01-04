import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';

class welcomescreen extends StatefulWidget {
  const welcomescreen({super.key});

  @override
  State<welcomescreen> createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen>
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
    return SafeArea(
      minimum: EdgeInsets.all(25),
      child: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Text(
                        'Shippo',
                        style: GoogleFonts.poppins(
                            color: Color(0xffF5E65F),
                            textBaseline: TextBaseline.ideographic,
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Image.asset(
                    'images/welcome.png',
                  ),
                  height: 173,
                  width: 323,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Welcome to shippo!',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF2F55F)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Delivering Confidence Through Every Mile.',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffc1c1c1)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                      title: 'Get Started',
                      colour: Color(0xffF2F55F),
                      animation2: animation2,
                      animation: animation,
                      onPressed: () {
                        Navigator.pushNamed(context, 'login_screen');
                      },
                      icon: Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
