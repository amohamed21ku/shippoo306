
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/constants.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:shippoo306/models/Sqldb.dart';


class addingDriver extends StatelessWidget {
  addingDriver({super.key});

  Sqldb sqlDB = Sqldb();
  String Firstname ='';
  String Lastname ='';
  String Phone ='';



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
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            'Adding Driver',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 3,
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
                              Phone = value;
                            },
                            decoration: kTextfielDecoration.copyWith(
                                hintText: "Phone Number",
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                )
                            ),
                          ),




                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundedButton_withicon(
                                    colour: Colors.yellow,
                                    title: "ADD",
                                    onPressed: () async{
                                      if (Firstname == '' || Lastname == '' || Phone=='') {
                                        ArtSweetAlert.show(
                                            context: context,
                                            artDialogArgs: ArtDialogArgs(
                                                type: ArtSweetAlertType.warning,
                                                title: 'ERROR',
                                                text:
                                                "Please Enter all the Required Fields"));
                                      }else{
                                        Navigator.pop(context);
                                        sqlDB.insertData('''
                                        INSERT INTO Driver ( Firstname, Lastname,Phone)
                                        VALUES
                                        ('$Firstname', '$Lastname', '$Phone');''');
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
