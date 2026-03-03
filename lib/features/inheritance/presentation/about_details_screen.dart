import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/core/widgets/styled_html_view.dart';

class AboutDetailScreen extends StatefulWidget {
  final String title;
  final String html;
  final IconData icon;
  final Color color;
  final List<String>? images;

  const AboutDetailScreen({
    super.key,
    required this.title,
    required this.html,
    required this.icon,
    required this.color,
    this.images,
  });

  @override
  State<AboutDetailScreen> createState() => _AboutDetailScreenState();
}

class _AboutDetailScreenState extends State<AboutDetailScreen> {
  bool showImages = false;
  @override
  Widget build(BuildContext context) {
    context.locale;

    return MainScaffold(
      appBarTitle: widget.title.t(),
      onLocaleChange: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder:
                (_) => AboutDetailScreen(
                  title: widget.title,
                  html: widget.html,
                  icon: widget.icon,
                  color: widget.color,
                  images: widget.images,
                ),
          ),
        );
      },
      child: SingleChildScrollView(
        // padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Large animated icon
            Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withOpacity(0.15),
                  ),
                  child: Icon(widget.icon, size: 60, color: widget.color),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),

            const SizedBox(height: 30),

            // Title
            Text(
              widget.title.t(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
            const SizedBox(height: 20),
            StreamingHtmlView(
              rawResponseHtml: widget.html.t(),
              animate: true,
              accentColor: context.primaryColor,
              onAnimateFinish: () {
                setState(() {
                  showImages = true;
                });
              },
            ),
            if (widget.images?.isNotEmpty == true && showImages)
              Column(
                children: [
                  ...List.generate(widget.images!.length, (index) {
                    return Image.asset(
                      widget.images![index].replaceFirst('locale', context.locale.languageCode),
                    );
                  }),
                ],
              ),
            // Full Body (Scrollable)
            // Text(
            //   html,
            //   textAlign: TextAlign.justify,
            //   style: const TextStyle(fontSize: 17, height: 1.6),
            // ).animate().fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
