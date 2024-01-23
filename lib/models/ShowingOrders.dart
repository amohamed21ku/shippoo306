import 'package:flutter/material.dart';
import 'package:shippoo306/widgets/infolist.dart';
import 'package:shippoo306/widgets/infocard.dart';
import '../Screens/OrderInfoPage.dart';
import '../models/Sqldb.dart';

class ShowingOrders extends StatelessWidget {
  final String sql;
  ShowingOrders({required this.sql});
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
                name: 'From: ${emp['SenderFirstname']} ${emp['SenderLastname']}',
                Date: 'To: ${emp['ReceiverFirstname']} ${emp['ReceiverLastname']}',
                onpress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderInfoPage(orderDetails: emp),
                    ),
                  );
                }
                ,  intial: '${emp['SenderFirstname'][0]}',

              ),
            );
          }

          return InfoList(info: employeeCards);
        }
      },
    );
  }
}
