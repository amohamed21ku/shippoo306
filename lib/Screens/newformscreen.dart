import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shippoo306/components.dart';

class newformscreen extends StatelessWidget {
  const newformscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242422),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Ensure children take the full width
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 130, right: 130),
                child: Container(
                  height: 4,
                  color: Colors.white24,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'New Order',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Send From',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(child: MY_textField(hint_text: "Name")),
                  SizedBox(width: 20),
                  Expanded(child: MY_textField(hint_text: "Surname")),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(child: MY_textField(hint_text: "Email")),
                  SizedBox(width: 20),
                  Expanded(child: MY_textField(hint_text: "phone Number")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MY_textField(hint_text: ''),
              SizedBox(
                height: 45,
              ),
              Text(
                'Send To',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(child: MY_textField(hint_text: "Name")),
                  SizedBox(width: 20),
                  Expanded(child: MY_textField(hint_text: "Surname")),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(child: MY_textField(hint_text: "Email")),
                  SizedBox(width: 20),
                  Expanded(child: MY_textField(hint_text: "Phone Number")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MY_textField(hint_text: ""),
              RoundedButton2(
                colour: Colors.yellow,
                title: "Sumbit",
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
