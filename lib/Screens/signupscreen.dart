import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/constants.dart';

class signupscreen extends StatelessWidget {
  const signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Text(
                          'Shippo',
                          textAlign: TextAlign.center,
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
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        'Create Account',
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      TextField(
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            //Do something with the user input.
                          },
                          decoration: kTextfielDecoration.copyWith(
                              hintText: "FULL NAME",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ))),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: false,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "EMAIL",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            )),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: true,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "PASSWORD",
                            prefixIcon: Icon(
                              Icons.lock_open_outlined,
                              color: Colors.grey,
                            )),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: true,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "CONFIRM PASSWORD",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton_withicon(
                                colour: Colors.yellow,
                                title: "SIGN UP",
                                onPressed: () {
                                  Navigator.pushNamed(context, 'home_screen');
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
