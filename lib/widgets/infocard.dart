import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class infoCard extends StatelessWidget {
  var onpress;
  String name;
  IconData icon;
  String Date;
  late var Prof_icon;

  infoCard({
    this.icon = Icons.person,
    required this.name,
    required this.Date,
    required this.onpress,

    // required this.checkboxCallback,
    // this.longPressCallback
  });
  @override
  Widget build(BuildContext context) {
    if (this.name == "") {
      Prof_icon = Icon(Icons.person);
    } else {
      Prof_icon = Text(
        '${this.name[0]}',
        style: GoogleFonts.poppins(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'info_screen');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5),
        height: 70,
        decoration: BoxDecoration(
            color: Color(0xff242422), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Prof_icon,
                  // backgroundColor: Color(0xffC95149),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${this.name}',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${this.Date}',
                      style: GoogleFonts.poppins(
                          fontSize: 10, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
