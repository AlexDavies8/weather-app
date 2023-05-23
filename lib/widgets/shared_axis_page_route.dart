import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// A class representing page change routes and transitions that use the [SharedAxisTransition] class
class SharedAxisPageRoute extends PageRouteBuilder {
  SharedAxisPageRoute(
      {required Widget page, required SharedAxisTransitionType transitionType})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation primaryAnimation,
            Animation secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: transitionType,
              child: child,
            );
          },
        );
}
