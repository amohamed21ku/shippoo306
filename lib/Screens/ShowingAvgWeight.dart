import 'package:flutter/material.dart';
import '../models/Sqldb.dart';

class ShowingAvgWeight extends StatelessWidget {
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

            // Extract average weight from the first row
            double averageWeight = data.isNotEmpty ? data.first['AverageWeight'] ?? 0.0 : 0.0;

            // Remove the average weight row from the data list
            data.removeAt(0);

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
                      var customer = data[index];
                      return ListTile(
                        title: Text('${customer['CustomerID']} - ${customer['Firstname']} ${customer['Lastname']}'),
                        subtitle: Text('Total Orders: ${customer['TotalOrders']}'),
                        // Add more fields as needed
                        onTap: () {
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
