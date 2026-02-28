import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/features/inheritance/presentation/about_details_screen.dart';
import 'package:inheritance/utils/assets/assets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return MainScaffold(
      appBarTitle: "about_section_title".t(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _HeaderSection(),
            const SizedBox(height: 25),

            _InfoCard(
              title: "about_section_title".t(),
              body: "about_section_body".t(),
              html: "about_section_html".t(),
              icon: Icons.info_outline,
              color: Colors.blue,
            ),

            _InfoCard(
              title: "about_how_title".t(),
              body: "about_how_body".t(),
              html: "about_how_html".t(),
              icon: Icons.psychology,
              color: Colors.deepPurple,
            ),

            _InfoCard(
              title: "about_disclaimer_title".t(),
              body: "about_disclaimer_body".t(),
              html: "about_disclaimer_html".t(),
              icon: Icons.warning_amber,
              color: Colors.redAccent,
            ),

            _InfoCard(
              title: "about_limitations_title".t(),
              body: "about_limitations_body".t(),
              html: "about_limitations_html".t(),
              icon: Icons.block,
              color: Colors.orange,
            ),

            // _InfoCard(
            //   title: "about_version_title".t(),
            //   body: "about_version_body".t(),
            //   icon: Icons.verified,
            //   color: Colors.green,
            // ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

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
                    color: primary.withOpacity(0.1),
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
          "about_app_name".t(),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.4),

        const SizedBox(height: 8),

        // Text(
        //   "about_tagline".t(),
        //   textAlign: TextAlign.center,
        //   style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
        // ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final String html;
  final IconData icon;
  final Color color;

  const _InfoCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.html,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AboutDetailScreen(title: title, html: html, icon: icon, color: color),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.12), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.5, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3);
  }
}
