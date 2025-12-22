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

  @override
  Widget build(BuildContext context) {
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
        final _getVersion = snapshot.data?['version'] ?? '';
        final _getUpdateTime = snapshot.data?['updateTime'] ?? '';
        return MarkdownData(
          assetPath: 'assets/markdown/terms.md',
          version: _getVersion,
          updateTime: _getUpdateTime,
        );
      },
    );
  }
}
