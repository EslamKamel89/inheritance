import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/themes/themedata.dart';

class ResultDataWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final Clr palette;
  final EdgeInsetsGeometry padding;
  final double dividerIndent;
  final double rowSpacing;
  final double labelWidth;
  const ResultDataWidget({
    super.key,
    required this.data,
    required this.palette,
    this.padding = const EdgeInsets.all(16),
    this.dividerIndent = 12,
    this.rowSpacing = 10,
    this.labelWidth = 120,
  });

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.where((e) => e.value != null).toList(growable: false);

    return Container(
          decoration: BoxDecoration(
            color: palette.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: palette.primaryColor.withOpacity(0.15)),
          ),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(entries.length, (i) {
                  final e = entries[i];
                  final valueStr = _valueToDisplayString(e.value);

                  return _TableRowItem(
                        label: e.key,
                        value: valueStr,
                        palette: palette,
                        showDivider: i != entries.length - 1,
                      )
                      .animate(delay: (80 * i).ms)
                      .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                      .slideY(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOut);
                }),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms, curve: Curves.easeOut)
        .slideY(begin: 0.12, end: 0, duration: 380.ms, curve: Curves.easeOut);
  }

  static String _valueToDisplayString(dynamic value) {
    if (value is String && value.trim().isEmpty) {
      return '—';
    }
    return value.toString();
  }
}

class _TableRowItem extends StatelessWidget {
  const _TableRowItem({
    required this.label,
    required this.value,
    required this.palette,
    required this.showDivider,
  });

  final String label;
  final String value;
  final Clr palette;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final labelStyle = TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600);

    final valueStyle = TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400);

    return Column(
      children: [
        InkWell(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Copied "$value"'),
                backgroundColor: palette.primaryColorDark,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(milliseconds: 1000),
              ),
            );
          },
          splashColor: palette.primaryColorLight.withOpacity(0.2),
          highlightColor: palette.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text(label, style: labelStyle, softWrap: true)),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(value, style: valueStyle, softWrap: true),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, thickness: 1, color: palette.primaryColor.withOpacity(0.1)),
      ],
    );
  }
}
