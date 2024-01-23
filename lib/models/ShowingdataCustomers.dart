import 'package:flutter/material.dart';
import 'package:shippoo306/widgets/infolist.dart';
import 'package:shippoo306/widgets/infocard.dart';
import '../Screens/CustomerInfoPage.dart';
import '../Screens/EmployeeInfoPage.dart';
import '../models/Sqldb.dart';

class ShowingDataCustomer extends StatelessWidget {
  final String sql;
  ShowingDataCustomer({required this.sql});
  final Sqldb sqlDB = Sqldb();


  Future<List<Map<String, dynamic>>> empInfo() async {
    return await sqlDB.readData(sql);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: empInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<infoCard> employeeCards = [];
          for (var emp in snapshot.data!) {
            employeeCards.add(
              infoCard(
                name: '${emp['Firstname']} ${emp['Lastname']}',
                Date: 'Customer ID: ${emp['CustomerID']}',
                onpress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerInfoPage(employeeDetails: emp),
                    ),
                  );
                }, intial: '${emp['Firstname'][0]}',

              ),
            );
          }

          return InfoList(info: employeeCards);
        }
      },
    );
  }
}
