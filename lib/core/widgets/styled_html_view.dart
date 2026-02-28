import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';

String cleanHtml(String raw) {
  var s = raw.trim();
  if (s.startsWith('```html')) {
    s = s.substring('```html'.length).trim();
  } else if (s.startsWith('```')) {
    s = s.substring(3).trim();
  }
  if (s.endsWith('```')) {
    s = s.substring(0, s.length - 3).trim();
  }
  return s;
}

class StyledHtmlView extends StatelessWidget {
  final String rawResponseHtml;
  final bool addStyling;
  final Color? accentColor;
  final Color? surfaceColor;

  const StyledHtmlView({
    required this.rawResponseHtml,
    super.key,
    this.addStyling = true,
    this.accentColor,
    this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    final html = cleanHtml(rawResponseHtml);

    final Color accent = accentColor ?? Theme.of(context).colorScheme.primary;
    final Color accentSoft = accent.withOpacity(0.05);
    final Color surface = surfaceColor ?? Theme.of(context).colorScheme.surface;
    final Color mutedText = Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.9);

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
          boxShadow: const [
            BoxShadow(blurRadius: 8, offset: Offset(0, 3), color: Color.fromRGBO(0, 0, 0, 0.04)),
          ],
        ),
        child: Html(
          data: html,
          shrinkWrap: true,
          style:
              addStyling
                  ? {
                    // Base reset
                    'body': Style(
                      padding: HtmlPaddings.zero,
                      margin: Margins.zero,
                      fontSize: FontSize(16),
                      lineHeight: LineHeight(1.75),
                      textAlign: TextAlign.start,
                      color: mutedText,
                    ),

                    '*': Style(letterSpacing: 0.2),

                    // Titles
                    'h1': Style(
                      display: Display.block,
                      fontSize: FontSize(22),
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      padding: HtmlPaddings.symmetric(vertical: 10, horizontal: 18),
                      margin: Margins.symmetric(vertical: 6),
                      backgroundColor: accent,
                      textAlign: TextAlign.center,
                    ),
                    'h2': Style(
                      fontSize: FontSize(18),
                      fontWeight: FontWeight.w800,
                      margin: Margins.only(top: 16, bottom: 8),
                      padding: HtmlPaddings.only(bottom: 6),
                      color: accent,
                    ),
                    'h3': Style(
                      fontSize: FontSize(17),
                      fontWeight: FontWeight.w700,
                      margin: Margins.only(top: 12, bottom: 6),
                    ),
                    'h4': Style(
                      fontSize: FontSize(15),
                      fontWeight: FontWeight.w700,
                      margin: Margins.only(top: 10, bottom: 6),
                    ),

                    // Paragraphs
                    'p': Style(
                      fontSize: FontSize(15.5),
                      margin: Margins.symmetric(vertical: 6),
                      color: mutedText,
                    ),

                    // Lists
                    'ul': Style(
                      margin: Margins.symmetric(vertical: 6),
                      padding: HtmlPaddings.only(right: 8),
                    ),
                    'ol': Style(
                      margin: Margins.symmetric(vertical: 6),
                      padding: HtmlPaddings.only(right: 8),
                    ),
                    'li': Style(
                      fontSize: FontSize(15.5),
                      margin: Margins.symmetric(vertical: 6),
                      padding: HtmlPaddings.symmetric(vertical: 10, horizontal: 10),
                      backgroundColor: accentSoft,
                      textAlign: TextAlign.start,
                    ),

                    'strong': Style(fontWeight: FontWeight.w800, color: Colors.black87),

                    'a': Style(textDecoration: TextDecoration.underline, color: accent),

                    'hr': Style(
                      margin: Margins.symmetric(vertical: 14),
                      padding: HtmlPaddings.zero,
                      backgroundColor: Colors.transparent,
                    ),

                    'blockquote': Style(
                      margin: Margins.symmetric(vertical: 10),
                      padding: HtmlPaddings.symmetric(vertical: 10, horizontal: 12),
                      backgroundColor: accent.withOpacity(0.04),
                      fontStyle: FontStyle.italic,
                    ),

                    // 🔹 Semantic AI annotations

                    // Quran verses
                    'span[data-type="quran"]': Style(
                      fontSize: FontSize(18),
                      fontWeight: FontWeight.w700,
                      color: accent,
                      textAlign: TextAlign.center,
                      margin: Margins.symmetric(vertical: 10),
                      display: Display.block,
                    ),

                    // Definitions / explanations
                    'blockquote[data-type="definition"]': Style(
                      backgroundColor: accent.withOpacity(0.06),
                      padding: HtmlPaddings.all(12),
                      margin: Margins.symmetric(vertical: 12),
                      fontStyle: FontStyle.italic,
                    ),

                    // Logical contrast / negation
                    'strong[data-type="contrast"]': Style(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  }
                  : {},
          onLinkTap: (url, _, __) {},
        ),
      ),
    );
  }
}

class StreamingHtmlView extends StatefulWidget {
  final String rawResponseHtml;
  final Color? accentColor;
  final Color? surfaceColor;
  final bool animate;
  const StreamingHtmlView({
    super.key,
    required this.rawResponseHtml,
    this.accentColor,
    this.surfaceColor,
    this.animate = false,
  });

  @override
  State<StreamingHtmlView> createState() => _StreamingHtmlViewState();
}

class _StreamingHtmlViewState extends State<StreamingHtmlView> {
  String visibleHtml = "";
  Timer? _timer;
  int _index = 0;

  // Speed control (lower = faster typing)
  final int typingSpeedMs = 6;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _startStreaming();
    } else {
      visibleHtml = widget.rawResponseHtml;
    }
  }

  void _startStreaming() {
    _timer = Timer.periodic(Duration(milliseconds: typingSpeedMs), (timer) {
      if (_index >= widget.rawResponseHtml.length) {
        timer.cancel();
        return;
      }

      setState(() {
        _index++;
        visibleHtml = widget.rawResponseHtml.substring(0, _index);
      });
    });
  }

  @override
  void dispose() {
    if (widget.animate) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StyledHtmlView(
          rawResponseHtml: visibleHtml,
          accentColor: widget.accentColor,
          surfaceColor: widget.surfaceColor,
          addStyling: true,
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.05, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}
