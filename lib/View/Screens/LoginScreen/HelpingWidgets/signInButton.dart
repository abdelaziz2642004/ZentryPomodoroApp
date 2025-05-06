import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_states.dart';
import 'package:prj/core/colors.dart';

class SignButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String type;

  const SignButton({required this.onPressed, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final bool isLoading = state is AuthLoadingState;

        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child:
              isLoading
                  ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                  : Text(
                    'Sign $type',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "DopisBold",
                    ),
                  ),
        );
      },
    );
  }
}
