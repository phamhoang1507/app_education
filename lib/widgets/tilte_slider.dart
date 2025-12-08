import 'package:education_app/utilities/common_variables.dart';
import 'package:flutter/material.dart';

class TilteSlider extends StatelessWidget {
  final String title;
  final String? textName;
  final Future<List<dynamic>> datas;
  final Widget Function(dynamic) slide;

  const TilteSlider({
    super.key,
    required this.title,
    this.textName,
    required this.datas,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            textName != null
                ? InkWell(
                    onTap: () {
                      print('Pressed All Subjects!');
                      // Do something here...
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          textName!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9547ED),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.keyboard_arrow_right_sharp,
                          size: 30,
                          color: Color(0xFF9547ED),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(height: 5),
        FutureBuilder(
          future: datas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: commonBarPadding,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            }

            final List<dynamic> datas = snapshot.data ?? [];

            if (datas.isEmpty) {
              return const Center(child: Text('Không có dữ liệu'));
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: datas.map((data) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: slide(data),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
