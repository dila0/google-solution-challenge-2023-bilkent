import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';

class SnackBarUtility {
  static const Color failureColor = kButtonColor;
  static const Color systemErrorColor = Color(0xffFFC66D);
  static const Color successColor = Colors.teal; //TODO change??
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

  static bool showFailureSnackBar(
      BuildContext context, String message, String title) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.failure,
        color: failureColor,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }

  static bool showSystemFailureSnackBar(
      BuildContext context, String message, String title) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.help,
        color: systemErrorColor,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }

  static bool showSuccessSnackBar(
      BuildContext context, String message, String title) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.success,
        color: successColor,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return true;
  }
}
