import 'package:flutter/material.dart';
import 'package:shippoo306/components.dart';
import 'package:shippoo306/models/Sqldb.dart';

class DriverInfoPage extends StatelessWidget {
  final Sqldb sqldb = Sqldb();
  final Map<String, dynamic> employeeDetails;

  DriverInfoPage({required this.employeeDetails});

  Future<List<Map>> getOrdersByDriverId(int driverId) async {
    String sql = 'SELECT * FROM Orders WHERE DriverId = $driverId';
    return await sqldb.readData(sql);
  }

 Future<int> getcount(int driverId) async {
    String sql = 'SELECT count(*) FROM Orders WHERE DriverId = $driverId';
    return await sqldb.readData(sql);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Driver Info'),
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
                    '${employeeDetails['Firstname'][0]}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${employeeDetails['Firstname']} ${employeeDetails['Lastname']} ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Driver ID: ${employeeDetails['DriverId']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${employeeDetails['Phone']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Orders:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<List<Map>>(
                  future: getOrdersByDriverId(employeeDetails['DriverId']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error fetching order data: ${snapshot.error}');
                    } else {
                      List<Map> orders = snapshot.data ?? [];
                      return Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('OrderID: ${orders[index]['OrderId']}'),
                              subtitle: Text(
                                  'From: ${orders[index]['SenderLoc']}\nTo: ${orders[index]['ReceiverLoc']}\nStatus: ${orders[index]['Status']}'),
                            );
                          },
                        ),
                      );
                    }
                  },
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
