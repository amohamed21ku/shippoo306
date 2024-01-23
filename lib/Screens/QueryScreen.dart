import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/Screens/ShowingAvgWeight.dart';
import 'package:shippoo306/Screens/Showing_searchDrivers.dart';
import '../models/Sqldb.dart';
import 'ShowingSearchCustomers .dart';

class QueryScreen extends StatefulWidget {
  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sophisticated Queries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowingAvgWeight(
                      sql: '''
                      SELECT 
  o.OrderId,
  o.ShipmentDate,
  o.DeliveryDate,
  o.SenderLoc,
  o.ReceiverLoc,
  o.DriverId,
  o.Status,
  sender.Firstname AS SenderFirstname,
  sender.Lastname AS SenderLastname,
  receiver.Firstname AS ReceiverFirstname,
  receiver.Lastname AS ReceiverLastname,
  cargo.Description AS CargoDescription,
  cargo.Weight AS CargoWeight,
  cargo.Type AS CargoType
FROM 
  Orders o
JOIN 
  Customer sender ON o.SenderId = sender.CustomerID
JOIN 
  Customer receiver ON o.ReceiverId = receiver.CustomerID
LEFT JOIN
  Cargo ON o.OrderId = Cargo.OrderId
WHERE 
  cargo.Weight > (SELECT AVG(Weight) FROM Cargo)
ORDER BY 
  cargo.Weight DESC;

                     
                      '''
                    )
                  ),
                );
              },
              child: Text('Average Weight', style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowingSearchDrivers(
                      sql: '''
                        SELECT 
                          Driver.DriverId, 
                          Driver.Firstname, 
                          Driver.Lastname, 
                          COUNT(Orders.OrderId) AS DeliveredOrdersCount
                        FROM 
                          Driver
                        LEFT JOIN 
                          Orders ON Driver.DriverId = Orders.DriverId AND Orders.Status = 'Delivered'
                        GROUP BY 
                          Driver.DriverId, Driver.Firstname, Driver.Lastname;
                      ''',
                    ),
                  ),
                );
              },
              child: Text('Group By Drivers',style: GoogleFonts.poppins(color: Colors.black)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowingSearchCustomers(
                      sql: '''
                        SELECT 
                          Customer.CustomerID, 
                          Customer.Firstname, 
                          Customer.Lastname, 
                          COUNT(Orders.OrderId) AS TotalOrders
                        FROM 
                          Customer
                        JOIN 
                          Orders ON Customer.CustomerID = Orders.ReceiverId
                        GROUP BY 
                          Customer.CustomerID, Customer.Firstname, Customer.Lastname
                        ORDER BY 
                          TotalOrders DESC;
                      ''',
                    ),
                  ),
                );
              },
              child: Text('Frequent Customers', style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () => executeOrdersBetweenDates(context),
              child: Text('Orders Between Dates',style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            // Add two TextFields for entering start and end dates
            TextField(
              style: GoogleFonts.poppins(color: Colors.white),
              controller: startDateController,
              decoration: InputDecoration(labelText: 'Start Date'),
            ),
            TextField(
              style: GoogleFonts.poppins(color: Colors.white),

              controller: endDateController,
              decoration: InputDecoration(labelText: 'End Date'),
            ),

            // ... Add more buttons as needed
          ],
        ),
      ),
    );
  }

  void executeOrdersBetweenDates(BuildContext context) async {
    String startDate = startDateController.text;
    String endDate = endDateController.text;

    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      String sql = '''
        SELECT *
        FROM Orders
        WHERE ShipmentDate BETWEEN '$startDate' AND '$endDate';
      ''';

      List<Map> result = await Sqldb().readData(sql);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QueryResultScreen(result),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter both start and end dates.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class QueryResultScreen extends StatelessWidget {
  final List<Map> result;

  QueryResultScreen(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Query Result'),
      ),
      body: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('OrderID: ${result[index]['OrderId']}'),
            subtitle: Text('Shipment Date: ${result[index]['ShipmentDate']}'),
            // Add more fields as needed
          );
        },
      ),
    );
  }
}
