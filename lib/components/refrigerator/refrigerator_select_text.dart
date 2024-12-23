import 'package:flutter/material.dart';
import 'package:nutripic/utils/enums/storage_type.dart';
import 'package:nutripic/utils/palette.dart';

class RefrigeratorSelectText extends StatelessWidget {
  final StorageType type;
  final StorageType selected;
  final Function()? onTap;
  const RefrigeratorSelectText({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        // Container가 있어야 텍스트 외에도 탭 가능
        child: Container(
          color: Colors.transparent,
          height: 54,
          child: Center(
            child: Text(
              type.name,
              style: Palette.body.copyWith(
                fontSize: 16,
                fontWeight:
                    type == selected ? FontWeight.w600 : FontWeight.w400,
                color: type == selected ? Palette.white : Palette.gray300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
