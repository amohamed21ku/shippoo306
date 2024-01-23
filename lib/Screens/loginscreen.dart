import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/constants.dart';
import 'package:shippoo306/models/Sqldb.dart';
import 'package:shippoo306/models/User.dart';

class loginscreen extends StatefulWidget {
  loginscreen({super.key});


  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen>
    with SingleTickerProviderStateMixin {
  bool showSpinner = false;
  String username = '';
  String pass = '';
  Sqldb sqlDB = Sqldb();



  late AnimationController controller;
  late Animation animation;
  late Animation animation2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    animation =
        ColorTween(begin: Colors.yellow, end: Colors.black).animate(controller);
    animation2 =
        ColorTween(begin: Colors.black, end: Colors.yellow).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        // ),
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    // The main Coloum
                    children: <Widget>[
                      Expanded(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Login',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Access account',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            TextField(
                                style: GoogleFonts.poppins(color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  username = value;
                                  //Do something with the user input.
                                },
                                decoration: kTextfielDecoration.copyWith(
                                    hintText: "Enter your Username",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ))),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              style: GoogleFonts.poppins(color: Colors.black),
                              obscureText: true,
                              onChanged: (value) {
                                //Do something with the user input.
                                pass = value;
                              },
                              decoration: kTextfielDecoration.copyWith(
                                  hintText: "Enter your Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  )),
                            ),
                            RoundedButton(
                              title: 'Login',
                              colour: Colors.yellow,
                              animation2: animation2,
                              animation: animation,
                              onPressed: () async {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final user = username;

                                  List<Map> response = await sqlDB.readData('''
                                   SELECT User.Username, User.Password, Employee.* 
                                   FROM User JOIN Employee ON User.UserId = Employee.EmployeeId
                                    WHERE Username = '$username' and Password = '$pass';
                                 ''');
                                   bool found = false ;
                                   print('length: abdo ${response.length}');
                                    if (response.length == 1 ) {
                                      found = true;
                                      print(response[0]['EmployeeId']);
                                      print(response[0]['Firstname']);
                                      print(response[0]['Lastname']);
                                      print(response[0]['Position']);
                                      print(response[0]['Email']);
                                      print(response[0]['Phone']);
                                      User.currentuser = User(EmployeeId: response[0]['EmployeeId'], Email: response[0]['Email'], Firstname: response[0]['Firstname'], Lastname: response[0]['Lastname'], Position: response[0]['Position'], Phone: response[0]['Phone']);
                                      Navigator.pushNamed(
                                        context,
                                        'menuscreen',
                                        arguments: <String, String>{
                                          'name': 'not me',
                                        },
                                      );
                                    }

                                  if(found == false){throw Error();}
                                } catch (e) {
                                  if (username == '' || pass == '') {
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.warning,
                                            title: 'ERROR',
                                            text:
                                            "Please Enter all the Required Fields"));
                                  } else {
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.danger,
                                            title: 'ERROR',
                                            text:
                                            'Username or Password is wrong'));
                                    username = '';
                                    pass = '';
                                  }
                                  ;
                                }
                                ;
                                setState(() {
                                  showSpinner = false;
                                });
                              },
                              icon: Icons.arrow_forward,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "signupscreen");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?  ",
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                  Text(
                                    'Signup',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.yellow),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
