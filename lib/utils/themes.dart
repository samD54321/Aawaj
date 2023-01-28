import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        fontFamily: GoogleFonts.quicksand().fontFamily,
        cardColor: const Color(0xffBE40F9),
        canvasColor: const Color(0xffF5F5F5),
        primaryColor: const Color(0xffBE40F9),

        // THIS IS THE THEMES FOR THE FONTS
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: const Color(0xffBE40F9),
          ),
          headline2: TextStyle(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontSize: 32,
              fontWeight: FontWeight.bold),
          headline3: TextStyle(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontSize: 30,
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          bodyText1: TextStyle(
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        fontFamily: GoogleFonts.quicksand().fontFamily,
        cardColor: const Color.fromARGB(255, 40, 8, 54),
        canvasColor: const Color(0xffF5F5F5),
        primaryColor: const Color.fromARGB(255, 40, 8, 54),

        // THIS IS THE THEMES FOR THE FONTS
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 40, 8, 54),
          ),
          headline2: TextStyle(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontSize: 32,
              fontWeight: FontWeight.bold),
          bodyText1: TextStyle(
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      );
}
