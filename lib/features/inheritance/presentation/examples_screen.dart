import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/utils/assets/assets.dart';

class ExamplesScreen extends StatelessWidget {
  const ExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: "examples_title".t(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: const [
            _HeroSection(),
            SizedBox(height: 30),
            _Timeline(),
            SizedBox(height: 40),
            _ReadySection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final primary = context.primaryColor;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary.withOpacity(0.12),
                  ),
                )
                .animate(onPlay: (c) => c.repeat())
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.2, 1.2),
                  duration: 1600.ms,
                )
                .fadeOut(duration: 1600.ms),

            Image.asset(AssetsData.logo, width: 140)
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.7, 0.7), end: const Offset(1, 1)),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "examples_intro_title".t(),
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.4),
        const SizedBox(height: 10),
        Text(
          "examples_intro_body".t(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StepData("step1_title", "step1_body", Icons.attach_money),
      _StepData("step2_title", "step2_body", Icons.receipt_long),
      _StepData("step3_title", "step3_body", Icons.family_restroom),
      _StepData("step4_title", "step4_body", Icons.question_answer),
      _StepData("step5_title", "step5_body", Icons.analytics),
    ];

    return Column(
      children: List.generate(steps.length, (i) => _TimelineItem(step: steps[i], index: i)),
    );
  }
}

class _StepData {
  final String titleKey;
  final String bodyKey;
  final IconData icon;

  _StepData(this.titleKey, this.bodyKey, this.icon);
}

class _TimelineItem extends StatelessWidget {
  final _StepData step;
  final int index;

  const _TimelineItem({required this.step, required this.index});

  @override
  Widget build(BuildContext context) {
    final color = context.primaryColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(step.icon, color: Colors.white),
            ),
            if (index != 4) Container(width: 2, height: 70, color: color.withOpacity(0.4)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.05))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.titleKey.t(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(step.bodyKey.t(), style: const TextStyle(height: 1.5)),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: (150 * index).ms).slideX(begin: 0.3);
  }
}

class _ReadySection extends StatelessWidget {
  const _ReadySection();

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Text(
      "examples_ready".t(),
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ).animate().fadeIn().scale();
  }
}
