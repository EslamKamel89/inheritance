import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DefaultAnimation extends StatelessWidget {
  const DefaultAnimation({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return child.animate().fade(duration: 1000.ms, begin: 0, end: 1).scale(duration: 200.ms);
  }
}
