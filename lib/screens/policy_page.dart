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

  @override
  Widget build(BuildContext context) {
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
          assetPath: 'assets/markdown/policy_vi.md',
          title: 'Privacy Policy',
          version: data['version'] ?? '',
          updateTime: data['updateTime'] ?? '',
        );
      },
    );
  }
}
