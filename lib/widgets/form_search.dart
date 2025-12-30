import 'package:education_app/extensions/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormSearch extends StatelessWidget {
  final VoidCallback? onTap;
  const FormSearch({
    super.key,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        prefixIcon: const Icon(Icons.search),
        hintText: l10n.search,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 1,
                height: 24,
                color: Colors.grey,
                margin: const EdgeInsets.only(right: 8.0),
              ),
              InkWell(
                onTap: onTap,
                child: SvgPicture.asset(
                  'assets/images/adjustments-horizontal.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
