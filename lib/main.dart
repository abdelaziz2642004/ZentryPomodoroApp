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
import 'package:prj/ViewModel/Repositories/AccountOPS_Repo.dart';
import 'package:prj/ViewModel/Repositories/Auth_Repo.dart';
import 'package:prj/ViewModel/Repositories/Profile_Repo.dart';
import 'package:prj/ViewModel/Services/cloudinaryService.dart';
import 'package:prj/core/get_it.dart';
import 'View/Screens/SplashScreen.dart';
import 'ViewModel/Cubits/Room/RoomDetails/room_details_cubit.dart';

// I want if the user joins a room then disconnets from the internet
// and then reconnects to the internet, the app should show the room screen right away
// and not the login screen or TabsScreen
// so we will handle this part here
// in the realtime DB u will have a users collection and inside each user will have the room he is in
// when is disconnected from the internet we will set the room to null
// and when he reconnects we will check if the room is null or not
// if it is not null we will navigate to the room screen with that roomcode ( call the join room function and navigator.push roomscreen )
// and add the user also to the room in the realtime DB too
// and if the room is null we will navigate to the login screen
// and if the user is not logged in we will navigate to the login screen right away
// ay hora2
// lol
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // most important 2 lines for firebase
  setUpLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(AuthRepo())),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(ProfileRepo(CloudinaryService())),
        ),
        BlocProvider<AccountCubit>(
          create: (context) => AccountCubit(AccountopsRepo()),
        ),
        BlocProvider<GuestmodeCubit>(create: (context) => GuestmodeCubit()),
        BlocProvider<RoomCubit>(create: (context) => getIt<RoomCubit>()),
        // BlocProvider<RoomDetailsCubit>(create: (_) => getIt<RoomDetailsCubit>()),

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
