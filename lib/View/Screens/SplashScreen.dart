import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prj/core/colors.dart';

import 'LoginScreen/LoginScreen.dart';
//restore?

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/JSON/logo.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              "Zentry",
              style: GoogleFonts.breeSerif(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),
            Text(
              "Where Minds Meet to Study",
              style: GoogleFonts.breeSerif(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
