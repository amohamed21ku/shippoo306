import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shippoo/Provider/info_provider.dart';
import 'package:shippoo306/components.dart';
// import 'package:shippoo306/widgets/InfoList.dart';

class ButtonRow extends StatefulWidget {
  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  int activeButtonIndex = 0;

  void _handleButtonTap(int index) {
    setState(() {
      activeButtonIndex = index;
    });

    // Navigate to the DetailsScreen and pass data based on the button index.
    Navigator.pushNamed(
      context,
      '/details',
      arguments: activeButtonIndex,
    );
  }

  List<String> buttonLabels = [
    "New Order",
    "In Process",
    "Delivered",
    "Canceled"
  ];

  List<Widget> _buildButtons() {
    List<Widget> buttons = [];

    for (int i = 0; i < 4; i++) {
      buttons.add(
        TextButton(
          onPressed: () => _handleButtonTap(i),
          child: Expanded(
            child: Row(
              children: [
                Container(
                  width: 105,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: activeButtonIndex == i
                        ? Color(0xffF5E65F)
                        : Colors.transparent,
                    border: Border.all(
                      color: activeButtonIndex == i
                          ? Colors.transparent
                          : Color(0xffF5E65F),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      buttonLabels[i],
                      style: GoogleFonts.poppins(
                        color: activeButtonIndex == i
                            ? Colors.black
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: activeButtonIndex == i
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap the entire widget in SingleChildScrollView
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            // Wrap the row of buttons in SingleChildScrollView
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildButtons(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  buttonLabels[activeButtonIndex],
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('data'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
