import 'package:flutter/material.dart';
import '../models/Sqldb.dart';

class ShowingSearchDrivers extends StatelessWidget {
  final String sql;
  final Sqldb sqlDB = Sqldb();

  ShowingSearchDrivers({required this.sql});

  Future<List<Map<String, dynamic>>> driverInfo() async {
    return await sqlDB.readData(sql);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: driverInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<DataRow> driverRows = [];
            List<Map<String, dynamic>> data = snapshot.data ?? [];

            if (data.isEmpty) {
              return Center(child: Text('No result'));
            }

            for (var driver in data) {
              driverRows.add(DataRow(
                cells: [
                  DataCell(Text('${driver['DriverId']}')),
                  DataCell(Text('${driver['Firstname']} ${driver['Lastname']}')),
                  DataCell(Text('${driver['DeliveredOrdersCount']}')),
                ],
                onSelectChanged: (isSelected) {
                  // Handle row selection if needed
                },
              ));
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Total Delivered')),
                ],
                rows: driverRows,
              ),
            );
          }
        },
      ),
    );
  }
}
