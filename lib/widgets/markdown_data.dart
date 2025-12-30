import 'package:education_app/routers/navigation_manager.dart';
import 'package:education_app/utilities/common_variables.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MarkdownData extends StatefulWidget {
  final String assetPath;
  final String title;
  final String? version;
  final String? updateTime;

  const MarkdownData({
    super.key,
    required this.assetPath,
    required this.title,
    this.version,
    this.updateTime,
  });

  @override
  State<MarkdownData> createState() => _MarkdownDataState();
}

class _MarkdownDataState extends State<MarkdownData> {
  String _markdownData = '';

  @override
  void initState() {
    loadMarkdownData();
    super.initState();
  }

  Future<void> loadMarkdownData() async {
    String data = await DefaultAssetBundle.of(
      context,
    ).loadString(widget.assetPath);

    if (widget.version != null) {
      data = data.replaceAll('{{version}}', widget.version!);
    }
    if (widget.updateTime != null) {
      data = data.replaceAll('{{updateTime}}', widget.updateTime!);
    }
    setState(() => _markdownData = data);
    return;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (_markdownData.isEmpty) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 40,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp),
          color: Colors.black,
          onPressed: () => context.nav.pop(context),
        ),
        backgroundColor: Colors.white,
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: commonMarkDownPadding,
              child: MarkdownWidget(
                data: _markdownData,
                config: MarkdownConfig(
                  configs: [
                    PConfig(
                      textStyle: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    H1Config(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: scheme.primary,
                      ),
                    ),
                    H2Config(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                    H3Config(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
