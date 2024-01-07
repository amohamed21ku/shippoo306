import 'package:flutter/material.dart';
import 'package:shippoo306/Screens/welcomescreen.dart';
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
      initialRoute: 'welcome_screen',
      routes: {
        "welcome_screen": (context) => welcomescreen(),
        // "login_screen": (context) => loginscreen(),
        // "register_screen": (context) => register_screen(),
        // "home_screen": (context) => HomeScreen(),
        // "newform_screen": (context) => newformscreen(),
        // "info_screen": (context) => infoscreen(),
        // "profilepage": (context) => ProfilePage()
      },
      home: welcomescreen(),
    );
  }
}
