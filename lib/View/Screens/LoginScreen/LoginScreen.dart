import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:prj/View/Screens/LoginScreen/HelpingWidgets/LoggingForm.dart';
import 'package:prj/View/Screens/SignUpScreen/signUpScreen.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_Cubit.dart';
import 'package:prj/core/colors.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/JSON/Welcome.json',
                    height: 200,
                    repeat: true,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DopisBold",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const LoginForm(), // Made LoginForm const

                  TextButton(
                    onPressed:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const SignupScreen(),
                          ), // Added const
                        ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 83, 83, 83),
                            fontFamily: "DopisBold",
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: "DopisBold",
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // ref.read(guestModeProvider.notifier).enableGuestMode();
                      BlocProvider.of<GuestmodeCubit>(
                        context,
                      ).enableGuestMode();
                    },
                    child: const Text(
                      "Continue as guest? ",
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: "DopisBold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
