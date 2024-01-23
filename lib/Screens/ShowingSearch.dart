import 'package:flutter/material.dart';
import 'package:shippoo306/widgets/infolist.dart';
import 'package:shippoo306/widgets/infocard.dart';
import '../Screens/OrderInfoPage.dart';
import '../models/Sqldb.dart';

class ShowingSearch extends StatelessWidget {
  final String sql;
  ShowingSearch({required this.sql});
  final Sqldb sqlDB = Sqldb();

  Future<List<Map<String, dynamic>>> empInfo() async {
    return await sqlDB.readData(sql);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: empInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<infoCard> employeeCards = [];
            List<Map<String, dynamic>> data = snapshot.data ?? [];

            if (data.isEmpty) {
              return Center(child: Text('No result'));
            }

            for (var emp in data) {
              print(emp);
              employeeCards.add(
                infoCard(
                  name: 'From: ${emp['SenderFirstname']??'Unknown'} ${emp['SenderLastname']??'Unknown'}',
                  Date: 'To: ${emp['ReceiverFirstname']??'Unknown'} ${emp['ReceiverLastname']??'Unknown'}',
                  onpress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderInfoPage(orderDetails: emp ),
                      ),
                    );
                  },
                  intial: '${emp['SenderFirstname'][0]??'U'}'

                ),
              );
            }

            return InfoList(info: employeeCards);
          }
        },
      ),
    );
  }
}
