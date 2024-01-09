import 'package:flutter/material.dart';
import 'package:shippoo306/widgets/infolist.dart';
import 'package:shippoo306/widgets/infocard.dart';
import '../models/Sqldb.dart';

class ShowingData extends StatelessWidget {
  final Sqldb sqlDB = Sqldb();

  Future<List<Map<String, dynamic>>> empInfo() async {
    return await sqlDB.readData('SELECT * FROM employee;');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: empInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<infoCard> employeeCards = [];
          for (var emp in snapshot.data!) {
            employeeCards.add(
              infoCard(
                name: '${emp['Firstname']} ${emp['Lastname']}',
                Date: 'Employee ID: ${emp['EmployeeId']}',
                onpress: () {},
              ),
            );
          }

          return InfoList(info: employeeCards);
        }
      },
    );
  }
}

