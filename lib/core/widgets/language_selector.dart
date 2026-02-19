import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';

    return PopupMenuButton<Locale>(
      tooltip: '',
      padding: EdgeInsets.zero,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (locale) {
        context.setLocale(locale);
      },
      itemBuilder:
          (context) => [
            _item(context, label: 'English', locale: const Locale('en'), selected: isEnglish),
            _item(context, label: 'العربية', locale: const Locale('ar'), selected: !isEnglish),
          ],

      /// ⭐ Custom trigger (globe + current lang indicator)
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 18),
            const SizedBox(width: 6),
            Text(
              isEnglish ? 'EN' : 'ع',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<Locale> _item(
    BuildContext context, {
    required String label,
    required Locale locale,
    required bool selected,
  }) {
    return PopupMenuItem<Locale>(
      value: locale,
      child: Row(
        children: [
          Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            size: 18,
            color: selected ? Theme.of(context).primaryColor : Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
