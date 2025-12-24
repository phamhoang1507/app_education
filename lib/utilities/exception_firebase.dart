import 'package:education_app/extensions/l10n.dart';
import 'package:flutter/material.dart';

class ExceptionFirebase {
  static String getErrorFirebase(dynamic e, BuildContext context) {
    final l10n = context.l10n;
    String errorMessage = l10n.errorDefault;

    if (e.code == 'invalid-credential') {
      errorMessage = l10n.errorInvalidCredential;
    } else if (e.code == 'user-not-found') {
      errorMessage = l10n.errorUserNotFound;
    } else if (e.code == 'wrong-password') {
      errorMessage = l10n.errorWrongPassword;
    } else if (e.code == 'too-many-requests') {
      errorMessage = l10n.errorTooManyRequests;
    } else if (e.code == 'expired-action-code') {
      errorMessage = l10n.errorExpiredActionCode;
    }
    return errorMessage;
  }
}
