import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/constants.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:shippoo306/models/Sqldb.dart';


class signupscreen extends StatelessWidget {
   signupscreen({super.key});

   Sqldb sqlDB = Sqldb();
   String Firstname ='';
  String Lastname ='';
  String Position ='';
  String Email ='';
  String Phone ='';

  String Username ='';
  String password ='';
  String verifyPassword='';

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
              child: Column(
                  children: [
                Expanded(
                  flex: 0,
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
                  child: Row(
                    children: [
                      Text(
                        'Create Account',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      TextField(
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            //Do something with the user input.
                            Firstname = value;
                          },
                          decoration: kTextfielDecoration.copyWith(
                              hintText: "First Name",
                              prefixIcon: Icon(
                                Icons.badge,
                                color: Colors.grey,
                              )
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: false,
                        onChanged: (value) {
                          //Do something with the user input.
                          Lastname = value;
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "Last Name",
                            prefixIcon: Icon(
                              Icons.badge,
                              color: Colors.grey,
                            )
                          ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: false,
                        onChanged: (value) {
                          //Do something with the user input.
                          Position = value;
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "Position",
                            prefixIcon: Icon(
                              Icons.work,
                              color: Colors.grey,
                            )
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: false,
                        onChanged: (value) {
                          //Do something with the user input.
                          Email = value;
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            )
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 2,
                        width: double.infinity, // Width of the vertical line
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: false,
                        onChanged: (value) {
                          //Do something with the user input.
                          Username = value;
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "Username",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            )
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: true,
                        onChanged: (value) {
                          //Do something with the user input.
                          password = value;
                        },
                        decoration: kTextfielDecoration.copyWith(
                            hintText: "PASSWORD",
                            prefixIcon: Icon(
                              Icons.lock_open_outlined,
                              color: Colors.grey,
                            )),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        style: GoogleFonts.poppins(color: Colors.black),
                        obscureText: true,
                        onChanged: (value) {
                          //Do something with the user input.
                          verifyPassword = value;
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
                                onPressed: () async{
                                  List<Map> response = await sqlDB.readData('''
                                 select username, password from user;
                                 ''');

    if (Firstname == '' || Lastname == '' || Position == '' || Email == '' || Username == '' || password
     == '' || verifyPassword == '') {
    ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
    type: ArtSweetAlertType.warning,
    title: 'ERROR',
    text:
    "Please Enter all the Required Fields"));
    } else if (password != verifyPassword){
    ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
    type: ArtSweetAlertType.danger,
    title: 'ERROR',
    text:
    "Password doesn't match"));}
    else {
      try{
      for (var i = 0; i < response.length; i++) {
        if (Username == response[i]['Username'] ) {
          throw Error();
        }
      }
      Navigator.pushNamed(context, 'loginscreen');
      sqlDB.insertData('''
      INSERT INTO Employee (Firstname, Lastname, Position, Email, Phone)
VALUES ('$Firstname', '$Lastname', '$Position', '$Email', '$Phone');''');

    sqlDB.insertData('''
      INSERT INTO User (Username, Password)
VALUES ('$Username', '$password');''');
      }
      catch(e){
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: 'ERROR',
                text:
                "Username already Signed"));
      }
    }

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
