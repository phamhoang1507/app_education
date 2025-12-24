import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/widgets/markdown_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  Future<Map<String, String>> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return {
      'version': packageInfo.version,
      'updateTime': DateFormat('dd/MM/yyyy').format(packageInfo.updateTime!),
    };
  }

  String _getFilePath(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    return language == 'vi'
        ? 'assets/markdown/terms_vi.md'
        : 'assets/markdown/terms_en.md';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FutureBuilder<Map<String, String>>(
      future: _getPackageInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        return MarkdownData(
          assetPath: _getFilePath(context),
          title: l10n.termsConditions,
          version: snapshot.data?['version'] ?? '',
          updateTime: snapshot.data?['updateTime'] ?? '',
        );
      },
    );
  }
}
