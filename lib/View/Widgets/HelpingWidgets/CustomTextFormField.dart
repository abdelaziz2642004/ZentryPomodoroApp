import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.textAlign,

  });

  final TextEditingController controller;
  Function validator;
  TextInputType? keyboardType;
  TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator(value),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      keyboardType: keyboardType,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
