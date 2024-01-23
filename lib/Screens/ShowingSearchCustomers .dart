import 'package:flutter/material.dart';
import '../models/Sqldb.dart';

class ShowingSearchCustomers extends StatelessWidget {
  final String sql;
  final Sqldb sqlDB = Sqldb();

  ShowingSearchCustomers({required this.sql});

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
            List<DataRow> customerRows = [];
            List<Map<String, dynamic>> data = snapshot.data ?? [];

            if (data.isEmpty) {
              return Center(child: Text('No result'));
            }

            for (var customer in data) {
              customerRows.add(DataRow(
                cells: [
                  DataCell(Text('${customer['CustomerID']}')),
                  DataCell(Text('${customer['Firstname']} ${customer['Lastname']}')),
                  DataCell(Text('${customer['TotalOrders']}')),
                ],
                onSelectChanged: (isSelected) {
                  // Handle row selection if needed
                },
              ));
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Total Orders')),
                  ],
                  rows: customerRows,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
