import 'package:flutter/material.dart';

class NavigationHelper {
  static Future<void> pushReplacement(
    BuildContext context,
    Widget destination, {
    Duration transitionDuration = const Duration(milliseconds: 1000),
  }) async {
    await Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: transitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: destination,
          );
        },
      ),
    );
  }
}
