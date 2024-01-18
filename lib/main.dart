import 'package:flutter/material.dart';
import 'package:shippoo306/Screens/CanceledScreen.dart';
import 'package:shippoo306/Screens/CustomerScreen.dart';
import 'package:shippoo306/Screens/DeliveredScreen.dart';
import 'package:shippoo306/Screens/Driverscreen.dart';
import 'package:shippoo306/Screens/InprocessScreen.dart';
import 'package:shippoo306/Screens/OrderTrackingPage.dart';
import 'package:shippoo306/Screens/homescreen.dart';
import 'package:shippoo306/Screens/newformscreen.dart';
import 'package:shippoo306/Screens/welcomescreen.dart';
import 'package:shippoo306/Screens/loginscreen.dart';
import 'package:shippoo306/Screens/signupscreen.dart';
import 'package:shippoo306/Screens/employeescreen.dart';
import 'Screens/EmployeeInfoPage.dart';
import 'Screens/addingEmployeeScreen.dart';
import 'Screens/menuscreen.dart';
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
        "homescreen": (context) =>homescreen(),
        "newformscreen": (context) => newformscreen(),
        "menuscreen": (context) => menuscreen(),
        "employeescreen": (context) => employeescreen(),
        "addingEmployee": (context) => addingEmployee(),
        "driverscreen": (context) => Driverscreen(),
        "customerscreen": (context) => CustomerScreen(),
        "ordertrackingpage": (context) => OrderTrackingPage(),
        "InprocessScreen": (context) => InprocessScreen(),
        "deliveredscreen": (context) => DeliveredScreen(),
        "canceledscreen": (context) => CanceledScreen(),

      },
      home: welcomescreen(),
    );
  }
}