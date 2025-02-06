import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class DiaryOptionModal extends StatelessWidget {
  final int diaryId;
  final Function? onTapPatch;
  final Function? onTapDelete;

  const DiaryOptionModal({
    super.key,
    required this.diaryId,
    required this.onTapPatch,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Palette.gray100.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용에 맞게 높이 조정
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                onTapPatch!();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.edit),
                  SizedBox(width: 20),
                  Text("수정", style: Palette.caption),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
              color: Palette.gray100,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
                onTapDelete!();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.delete_outline),
                  SizedBox(width: 20),
                  Text("삭제", style: Palette.caption),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
