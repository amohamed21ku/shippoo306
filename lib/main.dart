import 'package:flutter/material.dart';
import 'package:shippoo306/Screens/welcomescreen.dart';
import 'package:shippoo306/Screens/loginscreen.dart';
import 'package:shippoo306/Screens/signupscreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: 'welcomescreen',
      routes: {
        "welcomescreen": (context) => welcomescreen(),
        "loginscreen": (context) => loginscreen(),
        "signupscreen": (context) => signupscreen(),
        // "home_screen": (context) => HomeScreen(),
        // "newform_screen": (context) => newformscreen(),
        // "info_screen": (context) => infoscreen(),
        // "profilepage": (context) => ProfilePage()
      },
      home: welcomescreen(),
    );
  }
}
