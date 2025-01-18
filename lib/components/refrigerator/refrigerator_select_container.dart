import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_text.dart';
import 'package:nutripic/utils/enums/storage_type.dart';
import 'package:nutripic/utils/palette.dart';

class RefrigeratorSelectContainer extends StatelessWidget {
  final StorageType selected;
  final Function()? onTapRefrigerator;
  final Function()? onTapFreezer;
  final Function()? onTapCabinet;
  const RefrigeratorSelectContainer({
    super.key,
    required this.selected,
    required this.onTapRefrigerator,
    required this.onTapFreezer,
    required this.onTapCabinet,
  });

  @override
  Widget build(BuildContext context) {
    List<Alignment> alignment = [
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight
    ];

    return SizedBox(
      width: 276,
      height: 38,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          children: [
            // 선택된 항목 배경
            AnimatedAlign(
              alignment: alignment[selected.rawValue],
              duration: const Duration(milliseconds: 150),
              curve: Curves.fastOutSlowIn,
              child: Container(
                width: 84,
                height: 38,
                decoration: BoxDecoration(
                  color: Palette.gray00,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // 텍스트
            Row(
              children: [
                // 냉장
                RefrigeratorSelectText(
                  type: StorageType.fridge,
                  selected: selected,
                  onTap: onTapRefrigerator,
                ),
                const SizedBox(width: 12),

                // 냉동
                RefrigeratorSelectText(
                  type: StorageType.freezer,
                  selected: selected,
                  onTap: onTapFreezer,
                ),
                const SizedBox(width: 12),

                // 실온
                RefrigeratorSelectText(
                  type: StorageType.room,
                  selected: selected,
                  onTap: onTapCabinet,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
