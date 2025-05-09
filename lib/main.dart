import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/View/Screens/Tabs%20(%20Screen%20Chooser%20)/tabs.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_Cubit.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_States.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_cubit.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';
import 'package:prj/ViewModel/Cubits/accountOperations/account_cubit.dart';
import 'package:prj/View/Screens/LoginScreen/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'View/Screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<AccountCubit>(create: (context) => AccountCubit()),
        BlocProvider<GuestmodeCubit>(create: (context) => GuestmodeCubit()),
        BlocProvider<RoomCubit>(create: (context) => RoomCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
    BlocProvider.of<AuthCubit>(context).atStart();
  }

  void _startSplashTimer() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
            showSplash
                ? SplashScreen()
                : BlocBuilder<GuestmodeCubit, GuestmodeStates>(
                  builder: (context, guestModeState) {
                    if (guestModeState is GuestModeEnabledState) {
                      return const TabsScreen(); // Show TabsScreen if guest mode is enabled
                    }
                    return StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // return const Center(
                          //   child: CircularProgressIndicator(),
                          // );
                        }
                        if (snapshot.hasData) {
                          BlocProvider.of<GuestmodeCubit>(
                            context,
                          ).disableGuestMode();
                          return const TabsScreen();
                        } else {
                          return const Loginscreen();
                        }
                      },
                    );
                  },
                ),
      ),
    );
  }
}
