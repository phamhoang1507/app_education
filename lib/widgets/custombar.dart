import 'package:education_app/utilities/common_variables.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Custombar extends StatelessWidget {
  final bool? isLast;
  final Widget leading;
  final Widget? late;
  final VoidCallback? onTap;

  const Custombar({
    super.key,
    this.isLast = false,
    required this.leading,
    this.late,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: commonPaddingAll,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [leading, ?late],
            ),
          ),
        ),
        isLast != true
            ? Container(
                width: double.infinity,
                height: 2,
                color: HexColor('#E9EDF3'),
                margin: commonBarPadding,
              )
            : SizedBox(),
      ],
    );
  }
}
