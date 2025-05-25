import 'package:flutter/material.dart';

class CustomRouteBuilder {
  const CustomRouteBuilder();

  PageRouteBuilder<T> getRouteBuilder<T>(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Widget slideTransitionBuilder(BuildContext context,
      Animation animation, Animation secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
