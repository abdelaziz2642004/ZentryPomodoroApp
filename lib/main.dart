import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_Cubit.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_States.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_cubit.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/accountOperations/account_cubit.dart';

import 'package:prj/View/Screens/LoginScreen/LoginScreen.dart';
import 'package:prj/View/Screens/Tabs%20(%20Screen%20Chooser%20)/tabs.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // most important 2 lines for firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // most important 2 lines for firebase

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<AccountCubit>(create: (context) => AccountCubit()),
        BlocProvider<GuestmodeCubit>(create: (context) => GuestmodeCubit()),
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
  Widget screen = Container();
  @override
  void initState() {
    super.initState();
    screen = const Loginscreen();
    BlocProvider.of<AuthCubit>(context).atStart();
  }

  @override
  Widget build(BuildContext context) {
    // final bool guest = ref.watch(
    //   guestModeProvider,
    // ); // will get rebuild wheneevr the value changes , that's it :D much better than passing an ENTIRE FREAKING FUNCTION TO EVERY SMALL WIDGET

    // Screen = guest ? const TabsScreen() : const Loginscreen();
    // print(guest);
    //
    return MaterialApp(
      home: Scaffold(
        body: BlocBuilder<GuestmodeCubit, GuestmodeStates>(
          builder: (context, guestModeState) {
            if (guestModeState is GuestModeEnabledState) {
              return const TabsScreen(); // Show TabsScreen if guest mode is enabled
            }
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // return Center(
                  //   child: Lottie.asset('assets/JSON/loading.json'),
                  // );
                }
                if (snapshot.hasData) {
                  // to refresh with the new data !! :D
                  // ref.watch(guestModeProvider.notifier).disableGuestMode();
                  BlocProvider.of<GuestmodeCubit>(context).disableGuestMode();
                  return const TabsScreen();
                } else {
                  return screen;
                }
              },
            );
          },
        ),
      ),
    );
  }
}
