import 'package:flutter/material.dart';

class FormDropdown<T> extends StatelessWidget {
  final String title;
  final String hintText;
  final List<T> items;
  final int? selectedId;

  final int Function(T item) getId;
  final String Function(T item, Locale locale) getLabel;
  final ValueChanged<int?> onChanged;

  const FormDropdown({
    super.key,
    required this.title,
    required this.hintText,
    required this.items,
    this.selectedId,
    required this.getId,
    required this.getLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isExpanded: true,
              hint: Text(hintText),
              value: selectedId,
              items: items.map((item) {
                return DropdownMenuItem<int>(
                  value: getId(item),
                  child: Text(
                    getLabel(item, locale),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade600,
              ),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              menuMaxHeight: 250,
            ),
          ),
        ),
      ],
    );
  }
}
