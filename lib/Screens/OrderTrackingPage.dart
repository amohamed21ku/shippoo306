
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/models/Sqldb.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final TextEditingController orderIdController = TextEditingController();
  String orderStatus = '';
  late int orderid;

  Future<void> trackOrder() async {
    // Replace 'YOUR_DB_INSTANCE' with your actual database instance
Sqldb sqlDB = Sqldb();

    // Query the Orders table for the given orderId
    List<Map<String, dynamic>> result = await sqlDB.readData(
      "SELECT Status FROM Orders WHERE OrderId ='$orderid';"
    );

    if (result.isNotEmpty) {
      setState(() {
        orderStatus = 'Order Status: ${result.first['Status']}';
      });
    } else {
      setState(() {
        orderStatus = 'Order not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                orderid =int.parse(value);
                //Do something with the user input.
              },
              style: GoogleFonts.poppins(color: Colors.white),

              controller: orderIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Order ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: trackOrder,
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Text(
              orderStatus,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
