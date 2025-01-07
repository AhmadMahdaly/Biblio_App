import 'package:biblio/constants/colors_constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kDisableButtonColor,
      content: Text(
        text,
        style: const TextStyle(color: kMainColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
