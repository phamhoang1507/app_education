import 'package:education_app/extensions/l10n.dart';
import 'package:flutter/material.dart';

String formatToE164(String phone,BuildContext context, {String? countryCode}) {
  final l10n = context.l10n;
  phone = phone.trim().replaceAll(RegExp(r'[^\d]'), '');

  if (phone.startsWith('+')) {
    return phone;
  }

  if (phone.startsWith('0')) {
    if (countryCode == 'VN' || phone.length == 10) {
      return '+84${phone.substring(1)}';
    }
  }

  throw ArgumentError(l10n.errorInvalidPhoneFormat);
}
