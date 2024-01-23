import 'package:flutter/material.dart';
import 'package:shippoo306/components.dart';

class CustomerInfoPage extends StatelessWidget {
  final Map<String, dynamic> employeeDetails;

  CustomerInfoPage({required this.employeeDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Customer Info'),
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
                    '${employeeDetails['Firstname'][0]}', // Replace with the first letter of the first name
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${employeeDetails['Firstname']} ${employeeDetails['Lastname']} ', // Replace with the user's name and surname
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'CustomerID: ${employeeDetails['CustomerID']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${employeeDetails['Phone']}', // Replace with the user's phone number
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
