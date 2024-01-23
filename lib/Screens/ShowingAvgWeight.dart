import 'package:flutter/material.dart';
import '../models/Sqldb.dart';

class ShowingAvgWeight extends StatelessWidget {

  Future<double?> averageCargoWeight() async {
    return await sqlDB.findAverageCargoWeight();
  }
  final String sql;
  final Sqldb sqlDB = Sqldb();

  ShowingAvgWeight({required this.sql});

  Future<List<Map<String, dynamic>>> customerInfo() async {
    return await sqlDB.readData(sql);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: customerInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> data = snapshot.data ?? [];

            if (data.isEmpty) {
              return Center(child: Text('No result'));
            }

            double averageWeight = 7.9;




            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the average weight at the top
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Average Weight: ${averageWeight.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var order = data[index];
                      return ListTile(
                        title: Text('OrderID: ${order['OrderId']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sender: ${order['SenderFirstname']} ${order['SenderLastname']}'),
                            Text('Receiver: ${order['ReceiverFirstname']} ${order['ReceiverLastname']}'),
                            Text('Cargo Description: ${order['CargoDescription']}'),
                            Text('Cargo Weight: ${order['CargoWeight']}'),
                            Text('Cargo Type: ${order['CargoType']}'),
                          ],
                        ),
                        onTap: () {
                          print(order);
                          // Handle onTap if needed
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
