import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/features/our_work/data/apps.dart';
import 'package:inheritance/features/our_work/presentation/widgets/app_card.dart';

class OurWorkScreen extends StatelessWidget {
  const OurWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: "our_work_title".t(),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 30),
          ...apps.map((app) => AppCard(app: app)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
          "our_work_title".t(),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOut)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
  }
}
