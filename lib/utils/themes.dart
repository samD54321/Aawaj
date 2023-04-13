import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        fontFamily: GoogleFonts.quicksand().fontFamily,
        cardColor: const Color.fromARGB(255, 102, 9, 132),
        canvasColor: const Color(0xff2D033B),
        primaryColor: Colors.white,

        // THIS IS THE THEMES FOR THE FONTS
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: const Color(0xff810CA8),
          ),
          displayMedium: TextStyle(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white70),
          displaySmall: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      );

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        fontFamily: GoogleFonts.quicksand().fontFamily,
        cardColor: const Color.fromARGB(255, 228, 224, 230),
        canvasColor: const Color(0xffF5F5F5),
        primaryColor: Colors.black87,

        // THIS IS THE THEMES FOR THE FONTS
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 40, 8, 54),
          ),
          displayMedium: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          displaySmall: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          headlineMedium: TextStyle(
            fontFamily: GoogleFonts.quicksand().fontFamily,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      );
}
