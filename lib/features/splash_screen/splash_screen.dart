import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/router/app_routes_names.dart';
import 'package:inheritance/utils/assets/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(3000.ms, () {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.inheritanceScreen, (_) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.primaryColor;

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: context.primaryColor.withOpacity(0.2),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 0.9,
                  colors: [primary.withOpacity(0.22), Colors.black.withOpacity(0.95)],
                  stops: const [0.0, 1.0],
                  center: Alignment.topCenter,
                ),
              ),
            ),

            ...buildStars(),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary.withOpacity(0.08),
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1.15, 1.15),
                            duration: 1600.ms,
                            curve: Curves.easeInOut,
                          )
                          .fadeOut(duration: 1600.ms, curve: Curves.easeInOut),

                      Image.asset(AssetsData.logo, width: 150, height: 150)
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .scale(
                            begin: const Offset(0.85, 0.85),
                            end: const Offset(1, 1),
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          )
                          .shimmer(
                            duration: 1400.ms,
                            delay: 300.ms,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Text(
                        'Mirath',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 700.ms)
                      .moveY(begin: 16, end: 0, duration: 700.ms, curve: Curves.easeOut),

                  const SizedBox(height: 10),

                  const Text(
                        'Guided by Shariah. Built for peace of mind.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      )
                      .animate()
                      .fadeIn(delay: 900.ms, duration: 800.ms)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: 0, end: -4, duration: 1800.ms, curve: Curves.easeInOut),
                ],
              ).animate().moveY(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.bounceOut,
                begin: -300,
                end: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildStars() {
    final stars = <_StarSpec>[
      _StarSpec(const Offset(0.15, 0.20), 2.0, 0.ms),
      _StarSpec(const Offset(0.75, 0.18), 3.5, 300.ms),
      _StarSpec(const Offset(0.30, 0.35), 2.8, 700.ms),
      _StarSpec(const Offset(0.85, 0.40), 2.2, 1100.ms),
      _StarSpec(const Offset(0.10, 0.70), 3.0, 1400.ms),
      _StarSpec(const Offset(0.50, 0.80), 2.4, 1700.ms),
      _StarSpec(const Offset(0.88, 0.75), 2.1, 2000.ms),
    ];

    return stars.map((s) {
      return Align(
        alignment: Alignment(s.alignment.dx * 2 - 1, s.alignment.dy * 2 - 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.star_rounded, size: s.size + 6, color: Colors.white.withOpacity(0.12))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fadeIn(begin: 0.0, duration: 1600.ms, delay: s.delay, curve: Curves.easeInOut)
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.1, 1.1),
                duration: 1600.ms,
                delay: s.delay,
                curve: Curves.easeInOut,
              ),
        ),
      );
    }).toList();
  }
}

class _StarSpec {
  final Offset alignment;
  final double size;
  final Duration delay;
  const _StarSpec(this.alignment, this.size, this.delay);
}
