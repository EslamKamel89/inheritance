import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';

class AboutDetailScreen extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final Color color;

  const AboutDetailScreen({
    super.key,
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;

    return MainScaffold(
      appBarTitle: title,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Large animated icon
            Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.15)),
                  child: Icon(icon, size: 60, color: color),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),

            const SizedBox(height: 30),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),

            const SizedBox(height: 20),

            // Full Body (Scrollable)
            Text(
              body,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 17, height: 1.6),
            ).animate().fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
