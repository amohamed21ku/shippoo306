import 'package:flutter/material.dart';
import 'package:shippoo306/components.dart';

class OrderInfoPage extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  OrderInfoPage({required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Order Information'),
      ),
      body: Center(
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Text(
                    '${orderDetails['SenderFirstname'][0]}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Sender: ${orderDetails['SenderFirstname']} ${orderDetails['SenderLastname']}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Receiver: ${orderDetails['ReceiverFirstname']} ${orderDetails['ReceiverLastname']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'From: ${orderDetails['SenderLoc']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'To: ${orderDetails['ReceiverLoc']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                RoundedButton2(
                  onPressed: () {
                    // Implement your logout logic here
                    // For simplicity, we'll just navigate back to the previous screen
                    Navigator.pop(context);
                  },
                  colour: Colors.yellow,
                  title: 'Back',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
