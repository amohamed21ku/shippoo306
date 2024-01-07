import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/Mysql.dart';
import 'package:shippoo306/components.dart';

class welcomescreen extends StatefulWidget {
  welcomescreen({super.key});


  @override
  State<welcomescreen> createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  late Animation animation3;

  var db = new Mysql();

  late String text123='';

  void _getName(){

    db.getConnection().then((conn) {
      String sql = 'select user from user where user = "root";';
      conn.query(sql).then((results){
        for(var row in results){
          setState(() {
            text123 = row[0];


          });



        }


      });

    });



  }
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
                        text123,
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
                    Expanded(
                      flex : 1,
                      child: Text(
                        'Welcome to shippo!',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffF2F55F)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Delivering Confidence Through Every Mile.',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffc1c1c1)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: RoundedButton(
                        title: 'Get Started',
                        colour: Color(0xffF2F55F),
                        animation2: animation2,
                        animation: animation,
                        onPressed: () {
                          print("here is it1");
                          _getName();
                          // Navigator.pushNamed(context, 'login_screen');
                        },
                        icon: Icons.arrow_forward,
                      ),
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
