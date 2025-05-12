import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_Cubit.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_cubit.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/accountOperations/account_cubit.dart';
import 'package:prj/View/Screens/LoginScreen/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'View/Screens/SplashScreen.dart';
import 'ViewModel/Cubits/Room/create_room_cubit.dart';
import 'core/get_it.dart';

// test commit
// takii test commit

void main() async {
  // most important 2 lines for firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // most important 2 lines for firebase
  setUpLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<AccountCubit>(create: (context) => AccountCubit()),
        BlocProvider<GuestmodeCubit>(create: (context) => GuestmodeCubit()),
        BlocProvider<CreateRoomCubit>(create: (_) => getIt<CreateRoomCubit>()),
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
    return MaterialApp(home: SplashScreen());
  }
}
