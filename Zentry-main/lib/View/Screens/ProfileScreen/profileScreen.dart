import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/View/Screens/ProfileScreen/HelpingWidgets/profileInfo.dart';
import 'package:prj/View/Screens/ProfileScreen/HelpingWidgets/profileOptions.dart';
import 'package:prj/View/Screens/ProfileScreen/HelpingWidgets/profilePic.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_Cubit.dart';
import 'package:prj/core/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isUploading = false;

  void setUploadingState(bool value) {
    setState(() {
      isUploading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (can, T) {
        if (isUploading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please wait until the upload finishes.'),
            ),
          );
        }
      },
      canPop: isUploading == true ? false : true,

      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'DopisBold',
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfilePicture(onUploadStateChanged: setUploadingState),
                const SizedBox(height: 16),
                const ProfileInfo(),
                const Divider(),
                const ProfileOptions(),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed:
                      isUploading
                          ? null
                          : () async {
                            if (FirebaseAuth.instance.currentUser == null) {
                              // ref
                              //     .watch(guestModeProvider.notifier)
                              //     .disableGuestMode();
                              BlocProvider.of<GuestmodeCubit>(
                                context,
                              ).disableGuestMode();
                            } else {
                              // BlocProvider.of<AuthCubit>(context).logout();

                              await FirebaseAuth.instance.signOut();
                            }
                            Navigator.pop(context);
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    FirebaseAuth.instance.currentUser != null
                        ? 'Logout'
                        : 'Sign In',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
