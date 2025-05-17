import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ViewModel/Cubits/Room/create_room_cubit.dart';
import '../../../../core/colors.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRoomCubit, CreateRoomState>(
      builder:(context, state) {
        final isLoading = state is CreateRoomLoading;
        return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed:isLoading? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child:isLoading? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ) : const Text(
            "Create",
            style: TextStyle(color: white),
          ),
        ),
      );}
    );
  }
}