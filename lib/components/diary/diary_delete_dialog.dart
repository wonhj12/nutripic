import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class DiaryDeleteDialog extends StatelessWidget {
  final Function? onPressedCancel;
  final Function? onPressedDelete;

  const DiaryDeleteDialog({
    super.key,
    required this.onPressedCancel,
    required this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 181,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Icon(
              Icons.error_outline_rounded,
              size: 50,
              color: Palette.gray700,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "게시물을 삭제하시겠어요?",
              style: TextStyle(
                fontSize: 10,
                color: Palette.gray700,
              ),
            ),
            const Text(
              "삭제한 게시물은 복구할 수 없습니다.",
              style: TextStyle(
                fontSize: 8,
                color: Palette.gray500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      onPressedCancel!();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: Palette.gray300,
                      ),
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontSize: 8,
                        color: Palette.gray300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      onPressedDelete!();
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Palette.green500,
                      disabledBackgroundColor: Palette.gray100,
                    ),
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
