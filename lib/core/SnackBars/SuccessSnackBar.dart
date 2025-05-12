import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

SnackBar SuccessSnackBar({String msg = "Congratulations :)", String title = "Success!"}) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: msg,
      contentType: ContentType.success,
    ),
  );
}
