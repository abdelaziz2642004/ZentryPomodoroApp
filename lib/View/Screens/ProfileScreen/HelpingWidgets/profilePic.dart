import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_cubit.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_states.dart';
import 'package:prj/View/Screens/SignUpScreen/HelpingWIdgets/ImagePIcker.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, required this.onUploadStateChanged});
  final void Function(bool) onUploadStateChanged;

  @override
  State createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileErrorState) {
          return const Center(child: Icon(Icons.error, color: Colors.red));
        }
        return Stack(
          children: [
            UserImagePicker(
              onPickImage: (image) async {
                widget.onUploadStateChanged(true); // disable navigation
                await BlocProvider.of<ProfileCubit>(
                  context,
                ).changeImage(image, context);
                widget.onUploadStateChanged(false); // enable navigation
              },
              fromProfile: true,
            ),
          ],
        );
      },
    );
  }
}
