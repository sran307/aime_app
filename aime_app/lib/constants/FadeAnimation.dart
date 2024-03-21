import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 200.0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return AnimatedOpacity(
          opacity: value / 200.0, // Use the animated value to control opacity
          duration: const Duration(seconds: 1), // Set the opacity animation duration
          child: child,
        );
      },
      child: child, // Pass the child widget to the PlayAnimationBuilder
    );
  }
}
