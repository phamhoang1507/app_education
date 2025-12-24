import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/widgets/markdown_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  Future<Map<String, String>> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return {
      'version': packageInfo.version,
      'updateTime': DateFormat('dd/MM/yyyy').format(packageInfo.updateTime!),
    };
  }

  String _getFilePath(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    return language == 'vi'
        ? 'assets/markdown/policy_vi.md'
        : 'assets/markdown/policy_en.md';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FutureBuilder(
      future: _getPackageInfo(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (asyncSnapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${asyncSnapshot.error}')),
          );
        }
        final data = asyncSnapshot.data as Map<String, String>;
        return MarkdownData(
          assetPath: _getFilePath(context),
          title: l10n.privacyPolicy,
          version: data['version'] ?? '',
          updateTime: data['updateTime'] ?? '',
        );
      },
    );
  }
}
