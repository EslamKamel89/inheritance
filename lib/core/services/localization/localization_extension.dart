import 'package:easy_localization/easy_localization.dart';
import 'package:inheritance/core/globals.dart';
import 'package:inheritance/core/services/localization/localization_service.dart';

extension LocalizationExtension on String {
  String t() {
    final context = navigatorKey.currentContext;
    if (context == null) return this;
    final locale = context.locale.languageCode;
    return LocalizationService.instance.translate(this, locale);
  }
}
