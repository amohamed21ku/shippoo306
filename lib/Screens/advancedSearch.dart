import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/Sqldb.dart';
import 'ShowingSearch.dart';

class advancedSearch extends StatefulWidget {
  @override
  _advancedSearchState createState() => _advancedSearchState();
}

class _advancedSearchState extends State<advancedSearch> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();
  bool showStatistics = false;

  // Initialize counts for each status
  int inProcessCount = 0;
  int deliveredCount = 0;
  int canceledCount = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search by Location'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Search Orders',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  buildLocationTextField('From Location', fromController),
                  SizedBox(height: 20),
                  buildLocationTextField('To Location', toController),
                  SizedBox(height: 20),
                  buildLocationTextField('Customer Name or ID', customerSearchController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                    ),
                    onPressed: () {
                      String fromLocation = fromController.text;
                      String toLocation = toController.text;
                      String customerSearch = customerSearchController.text;

                      // Validate the entered locations and customer search (add your own validation logic)

                      // Navigate to the ShowingSearch screen with the entered locations and customer search
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowingSearch(
                            sql: '''SELECT
                              sender.Firstname AS SenderFirstname,
                              sender.Lastname AS SenderLastname,
                              receiver.Firstname AS ReceiverFirstname,
                              receiver.Lastname AS ReceiverLastname,
                              Orders.SenderLoc, Orders.ReceiverLoc,
                              MAX(Orders.OrderId) AS LatestOrderId,
                              MAX(Orders.SenderLoc) AS LatestSenderLoc,
                              MAX(Orders.ReceiverLoc) AS LatestReceiverLoc,
                              MAX(Orders.DriverId) AS LatestDriverId,
                              MAX(Orders.Status) AS LatestStatus
                            FROM
                              Orders
                            JOIN
                              Customer sender ON Orders.SenderId = sender.CustomerID
                            JOIN
                              Customer receiver ON Orders.ReceiverId = receiver.CustomerID
                            WHERE
                              (Orders.SenderLoc = '$fromLocation' OR Orders.ReceiverLoc = '$toLocation')
                              OR (
                                sender.Firstname LIKE '$customerSearch'
                                OR sender.Lastname LIKE '$customerSearch'
                                OR receiver.Firstname LIKE '$customerSearch'
                                OR receiver.Lastname LIKE '$customerSearch'
                                OR sender.CustomerID = '$customerSearch'
                                OR receiver.CustomerID = '$customerSearch'
                              )
                            GROUP BY
                              sender.CustomerID, receiver.CustomerID
                            ORDER BY
                              LatestOrderId DESC;
                          ''',
                          ),
                        ),
                      );
                    },
                    child: Text('Search', style: GoogleFonts.poppins(color: Colors.black)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      // Toggle the showStatistics variable to display/hide the statistics table
                      setState(() {
                        showStatistics = !showStatistics;

                        // Fetch and calculate the counts when the statistics table is displayed
                        if (showStatistics) {
                          fetchOrderCounts();
                        }
                      });
                    },
                    child: Text('See Statistics', style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  if (showStatistics) Expanded(child: Container(child: buildStatisticsTable())),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchOrderCounts() async {
    setState(() async {
      inProcessCount = await Sqldb().countInProcessOrders() ?? 0;
      deliveredCount = await Sqldb().countDeliveredOrders() ?? 0;
      canceledCount = await Sqldb().countCanceledOrders() ?? 0;

    });

    // Update the state to trigger a rebuild with the new counts
  }

  Widget buildStatisticsTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Total Orders')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('InProcess')),
          DataCell(Text('$inProcessCount')),
        ]),
        DataRow(cells: [
          DataCell(Text('Delivered')),
          DataCell(Text('$deliveredCount')),
        ]),
        DataRow(cells: [
          DataCell(Text('Canceled')),
          DataCell(Text('$canceledCount')),
        ]),
      ],
    );
  }

  Widget buildLocationTextField(String label, TextEditingController controller) {
    return TextField(
      style: GoogleFonts.poppins(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
