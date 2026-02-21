import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/heleprs/parse_string_to_int.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/themes/themedata.dart';
import 'package:inheritance/features/inheritance/models/grand_child_info_model.dart';

class InheritanceGrandChildInputWidget extends StatefulWidget {
  const InheritanceGrandChildInputWidget({super.key, required this.grandChild});
  final GrandChildInfoModel grandChild;

  @override
  State<InheritanceGrandChildInputWidget> createState() => _InheritanceGrandChildInputWidgetState();
}

class _InheritanceGrandChildInputWidgetState extends State<InheritanceGrandChildInputWidget> {
  late bool isAlive;

  @override
  void initState() {
    super.initState();
    isAlive = (widget.grandChild.status ?? 'alive') == 'alive';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 250)),
        ScaleEffect(begin: Offset(0.98, 0.98), end: Offset(1.0, 1.0), curve: Curves.easeOut),
      ],
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isAlive ? lightClr.primaryColor : lightClr.primaryColorDark.withOpacity(0.5),
            width: 1.2,
          ),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAlias,
        child: AnimatedContainer(
          duration: 300.ms,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.cardColor, theme.cardColor.withOpacity(0.96)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header row: Gender + Status
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.grading, color: lightClr.primaryColorDark),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "child".t(),
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  _StatusChip(isAlive: isAlive)
                      .animate()
                      .fadeIn(duration: 200.ms)
                      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
                ],
              ),

              const SizedBox(height: 12),

              // Gender display
              _LabeledValue(
                label: "gender".t(),
                value: widget.grandChild.gender?.display.toLowerCase().t() ?? '—',
                icon: Icons.wc,
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.heat_pump_rounded),
                  const SizedBox(width: 8),
                  Text(
                    "status".t(),
                    style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text("deceased".t(), style: theme.textTheme.bodySmall),
                  Switch(
                    value: isAlive,
                    onChanged: (v) {
                      setState(() {
                        isAlive = v;
                        widget.grandChild.status = v ? 'alive' : 'dead';
                      });
                    },
                    // activeThumbColor: lightClr.primaryColor,
                    inactiveThumbColor: theme.colorScheme.error,
                    inactiveTrackColor: theme.colorScheme.error.withOpacity(0.25),
                  ),
                  Text("alive".t(), style: theme.textTheme.bodySmall),
                ],
              ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.2, curve: Curves.easeOut),

              const Divider(height: 20),

              TextFormField(
                    initialValue: (widget.grandChild.grandChildrenMalesCount ?? 0).toString(),
                    onChanged: (v) {
                      widget.grandChild.grandChildrenMalesCount = parseStringToInt(v);
                      // Small nudge animation on change
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(
                      label: "grandchildren_males".t(),
                      hint: "enter_male_grandchildren".t(),
                      icon: Icons.male,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 200.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut, delay: 60.ms),

              const SizedBox(height: 12),

              TextFormField(
                    initialValue: (widget.grandChild.grandChildrenFemalesCount ?? 0).toString(),
                    onChanged: (v) {
                      widget.grandChild.grandChildrenFemalesCount = parseStringToInt(v);
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration(
                      label: "grandchildren_females".t(),
                      hint: "enter_female_grandchildren".t(),
                      icon: Icons.female,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 200.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut, delay: 120.ms),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String label, required String hint, IconData? icon}) {
    return InputDecoration(
      prefixIcon: icon != null ? Icon(icon) : null,
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: lightClr.primaryColor, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: lightClr.primaryColor.withOpacity(0.7), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: lightClr.primaryColorDark, width: 1.5),
      ),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      hintStyle: const TextStyle(fontSize: 13),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isAlive});
  final bool isAlive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = isAlive ? Colors.green.withOpacity(0.12) : theme.colorScheme.error.withOpacity(0.12);
    final fg = isAlive ? Colors.green.shade800 : theme.colorScheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          Icon(isAlive ? Icons.favorite : Icons.heart_broken, size: 16, color: fg),
          const SizedBox(width: 6),
          Text(
            isAlive ? 'alive'.t() : 'deceased'.t(),
            style: TextStyle(color: fg, fontWeight: FontWeight.w700, letterSpacing: 0.2),
          ),
        ],
      ),
    );
  }
}

class _LabeledValue extends StatelessWidget {
  const _LabeledValue({required this.label, required this.value, this.icon});
  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        if (icon != null) Icon(icon, size: 20),
        if (icon != null) const SizedBox(width: 8),
        Text(label, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(value, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
