import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/View/Screens/LoginScreen/HelpingWidgets/EmailField.dart';
import 'package:prj/View/Screens/LoginScreen/HelpingWidgets/passwordField.dart';
import 'package:prj/View/Screens/LoginScreen/HelpingWidgets/signInButton.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Services/LoginService.dart';
import 'package:prj/View/Screens/forgotPasswordScreen/forgotScreen.dart';
import 'package:prj/core/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final LoginService loginService;

  @override
  void initState() {
    super.initState();
    loginService = LoginService(context: context);
    BlocProvider.of<AuthCubit>(context).authRepo.loginService = loginService;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginService.formKey,
      child: Column(
        children: [
          EmailorUsernameField(
            onChanged: (value) => loginService.emailOrUsername = value,
          ),
          const SizedBox(height: 20),
          PasswordField(
            obscurePassword: loginService.obscurePassword,
            onChanged: (value) => loginService.password = value,
            toggleVisibility:
                () => setState(
                  () =>
                      loginService.obscurePassword =
                          !loginService.obscurePassword,
                ),
            labelText: "Password",
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const ForgotPasswordScreen(),
                      ),
                    ),
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: mainColor, fontFamily: "DopisBold"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SignButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).login(context);
            },
            type: "In",
          ),
        ],
      ),
    );
  }
}
