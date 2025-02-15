import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class CustomDropDown extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? defaultValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const CustomDropDown({
    super.key,
    this.label,
    this.hintText,
    this.defaultValue,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 레이블
        if (widget.label != null)
          Text(
            widget.label!,
            style: Palette.body2.copyWith(color: Palette.gray400),
          ),

        if (widget.label != null) const SizedBox(height: 6),

        DropdownButton2(
          hint: Text(
            widget.hintText ?? '선택하세요',
            style: Palette.body1.copyWith(color: Palette.gray400),
          ),
          underline: const SizedBox(), // underline 제거
          buttonStyleData: ButtonStyleData(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Palette.gray50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Palette.gray100),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: Palette.gray50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Palette.gray100),
            ),
            elevation: 0,
          ),
          isExpanded: true,
          value: selectedValue,
          items: widget.items
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: Palette.body1.copyWith(color: Palette.gray900),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            // 선택된 항목 업데이트
            setState(() {
              selectedValue = value;
            });

            // 선택된 항목 반환
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
