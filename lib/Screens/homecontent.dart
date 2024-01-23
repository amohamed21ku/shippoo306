import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/models/Sqldb.dart';


class ButtonRow extends StatefulWidget {
  int index;
  ButtonRow({this.index =0});
  @override
  _ButtonRowState createState() => _ButtonRowState(activeButtonIndex: index);

}

class _ButtonRowState extends State<ButtonRow> {
   int activeButtonIndex;
  _ButtonRowState({required this.activeButtonIndex});
  Sqldb sqldb = Sqldb();




  void handleButtonTap(int index) {
    setState(() {
      activeButtonIndex = index;
    });
    late String chosen_screen;
    if(activeButtonIndex == 0){chosen_screen = 'homescreen';}
    else if(activeButtonIndex ==1){chosen_screen = 'InprocessScreen';}
    else if (activeButtonIndex ==2 ){chosen_screen = 'deliveredscreen';}
    else if (activeButtonIndex ==3) {chosen_screen = 'canceledscreen';}


    Navigator.popAndPushNamed(context, chosen_screen);


  }

  List<String> buttonLabels = [
    "All Orders",
    "In Process",
    "Delivered",
    "Canceled"
  ];

  List<Widget> _buildButtons() {
    List<Widget> buttons = [];

    for (int i = 0; i < 4; i++) {
      buttons.add(
        TextButton(
          onPressed: () => handleButtonTap(i),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

              ],
            ),
          ),
        ],
      ),
    );
  }
}
