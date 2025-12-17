import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormSearch extends StatelessWidget {
  const FormSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search',
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
              SvgPicture.asset(
                'assets/images/adjustments-horizontal.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
