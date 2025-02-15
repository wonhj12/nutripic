import 'package:flutter/material.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/palette.dart';

class DiaryCard extends StatelessWidget {
  final Diary diary;
  final Function() onPressed;
  final String getTime;

  // TODO: 작성자 이름 추가

  const DiaryCard({
    super.key,
    required this.diary,
    required this.onPressed,
    required this.getTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        // height: 460,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Palette.gray00,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Palette.gray100),
          boxShadow: const [
            BoxShadow(
              color: Palette.gray100,
              blurRadius: 20,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Palette.gray200),
                      ),
                      child: Center(
                        child: Text(
                          getTime,
                          style: Palette.subtitle1SemiBold
                              .copyWith(color: Palette.gray600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Nutripic',
                      style: Palette.caption1medium
                          .copyWith(color: Palette.gray900),
                    ),
                  ],
                ),

                //게시글 별 메뉴바
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.more_vert, size: 20),
                )
              ],
            ),

            // 사진
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://cphoto.asiae.co.kr/listimglink/1/2020011513515297802_1579063912.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),

            // 게시글 부분
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              height: diary.body!.length > 30 ? 70 : 50,
              child: Text(
                diary.body ?? '',
                style: Palette.caption1.copyWith(color: Palette.gray900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
