import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackBarUtility {
  static void showSnackBar(BuildContext context, String message, String title,
      Color color, ContentType contentType) {
    final snackBar = SnackBar(
      elevation: 0, //TODO decide
      behavior: SnackBarBehavior.floating, //TODO decide
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        color: color,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFailureSnackBar(
      BuildContext context, String message, String title, Color color) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.failure,
        color: color,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
