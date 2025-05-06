import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prj/core/colors.dart';

import '../../Models/User.dart';
import '../../ViewModel/Cubits/GuestMode/GuestMode_Cubit.dart';
import '../../ViewModel/Cubits/GuestMode/GuestMode_States.dart';
import 'HomeScreen/HomeScreen.dart';
import 'LoginScreen/LoginScreen.dart';
import 'Tabs ( Screen Chooser )/tabs.dart';
//restore?

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 7));

    final guestState = BlocProvider.of<GuestmodeCubit>(context).state;
    final user = FirebaseAuth.instance.currentUser;

    if (guestState is GuestModeEnabledState) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TabsScreen()),
      );
    } else if (user != null) {
      BlocProvider.of<GuestmodeCubit>(context).disableGuestMode();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TabsScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Loginscreen()),
      );
    }
  }

  @override
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
            SizedBox(height: 20),
            Text(
              "Zentry",
              style: GoogleFonts.breeSerif(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),
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
