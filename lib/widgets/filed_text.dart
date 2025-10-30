import 'package:flutter/material.dart';

class FiledText extends StatefulWidget {
  final TextEditingController controller;
  final IconData? leadIcon;
  final List? lastIcon;
  final String hintText;
  final String textTitle;
  final GlobalKey keyForm;
  final FormFieldValidator? validator;
  final bool hiddenText;

  const FiledText({
    super.key,
    required this.controller,
    this.leadIcon,
    this.lastIcon,
    required this.hintText,
    required this.textTitle,
    required this.keyForm,
    required this.hiddenText,
    this.validator,
  });

  @override
  State<FiledText> createState() => _FiledTextState();
}

class _FiledTextState extends State<FiledText> {
  late bool check;

  @override
  void initState() {
    super.initState();
    check = widget.hiddenText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email'),
        TextFormField(
          obscureText: check,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: widget.leadIcon != null
                ? Icon(widget.leadIcon, color: Colors.grey)
                : null,
            suffixIcon: widget.lastIcon != null
                ? GestureDetector(
                    child: Icon(check ? widget.lastIcon![0] : widget.lastIcon![1], color: Colors.grey),
                    onTap: () {
                      setState(() {
                        check = !check;
                      });
                    },
                  )
                : null,
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1),
            ),
          ),
          key: widget.keyForm,
          validator: widget.validator,
        ),
      ],
    );
  }
}
