import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextfielDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffF5E65F), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  ),
);
