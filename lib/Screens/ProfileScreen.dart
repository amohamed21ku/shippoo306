import 'package:flutter/material.dart';
import 'package:shippoo306/components.dart';

import '../models/User.dart';

class ProfileScreen extends StatelessWidget {

  ProfileScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Text(
                    '${User.currentuser.Firstname[0]}', // Replace with the first letter of the first name
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${User.currentuser.Firstname} ${User.currentuser.Lastname} ', // Replace with the user's name and surname
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${User.currentuser.Email}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${User.currentuser.Phone}', // Replace with the user's phone number
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                RoundedButton2(
                  onPressed: () {
                    // Implement your logout logic here
                    // For simplicity, we'll just navigate back to the previous screen
                    Navigator.pushNamed(context, "login_screen");
                  },
                  colour: Colors.yellow,
                  title: 'Logout',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
