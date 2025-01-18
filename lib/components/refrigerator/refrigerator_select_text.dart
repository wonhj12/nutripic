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
          height: 40,
          child: Center(
            child: Text(
              type.name,
              style: Palette.title1SemiBold.copyWith(
                color: type == selected ? Palette.gray00 : Palette.gray300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
