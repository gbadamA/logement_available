import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Slide transition from right to left
Route slideFromRight(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

/// Fade transition
Route fadeTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

/// Scale transition (zoom-in)
Route scaleTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final scaleAnimation = Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
      return ScaleTransition(scale: scaleAnimation, child: child);
    },
  );
}

/// Lottie animation for success
Widget successAnimation({double height = 120}) {
  return Lottie.asset('assets/success.json', height: height);
}

/// Lottie animation for empty state
Widget emptyAnimation({double height = 140}) {
  return Lottie.asset('assets/animations/empty_box.json', height: height);
}

/// Lottie animation for loading
Widget loadingAnimation({double height = 100}) {
  return Lottie.asset('assets/loading.json', height: height);
}
