import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/utils/palette.dart';

Future<void> customDialog({
  required BuildContext context,
  required String title,
  required String detail,
  required Function() onPressed,
}) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 문구
            Text(title, style: Palette.title2Medium),
            const SizedBox(height: 28),

            // 부연 설명 문구
            Text(detail, style: Palette.caption1),
            const SizedBox(height: 24),

            // 취소, 확인
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 취소
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: FilledButton(
                      onPressed: context.pop,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Palette.gray300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Palette.gray00,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        '취소',
                        style: Palette.subtitle1Medium
                            .copyWith(color: Palette.gray300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 완료
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: FilledButton(
                      onPressed: () {
                        onPressed();
                        context.pop();
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Palette.green500,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        '완료',
                        style: Palette.subtitle1Medium
                            .copyWith(color: Palette.gray00),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
