import 'package:flutter/cupertino.dart';

class CustomAnimations {
  static PageRouteBuilder slideTransition(
      {required Widget page,
      bool reverse = false,
      Duration duration = const Duration(
        milliseconds: 170,
      )}) {
    double start = 0;
    double end = 1;
    if (!reverse) {
      start = 1;
      end = 0;
    }
    return PageRouteBuilder(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, b, c) => SlideTransition(
        position: Tween<Offset>(begin: Offset(start, 0), end: Offset(end, 0))
            .animate(a),
        child: c,
      ),
    );
  }
}
