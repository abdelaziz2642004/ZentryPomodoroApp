import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showErrorDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: const Text('Operation Failed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/JSON/failed.json',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              // Text(message),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
  );
}
