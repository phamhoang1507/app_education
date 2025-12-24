import 'package:education_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  
  Locale get currentLocale => Localizations.localeOf(this);
  
  bool get isVietnamese => currentLocale.languageCode == 'vi';
  bool get isEnglish => currentLocale.languageCode == 'en';
}