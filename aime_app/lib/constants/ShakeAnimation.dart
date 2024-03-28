import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class ShakeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  ShakeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            value * 10 * (value % 2 == 0 ? -1 : 1), // Adjust the amplitude of the shake
            0,
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
