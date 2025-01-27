import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

enum StatusType {
  //색 바꾸기
  low(Palette.green700),
  normal(Palette.green500);

  final Color color;
  const StatusType(this.color);
}

class DiarySummaryContainer extends StatelessWidget {
  final double percent;
  final StatusType type;
  final int totalDays;
  final int diaryDays;
  final String username;

  const DiarySummaryContainer({
    super.key,
    required this.percent,
    this.type = StatusType.normal,
    required this.totalDays,
    required this.diaryDays,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Palette.gray100,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //문구
          Text(
            '$username님',
            style: const TextStyle(
              color: Palette.gray900,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
          Text(
            '$totalDays일 중 $diaryDays일을 건강하게 식사했어요!',
            style: const TextStyle(
              color: Palette.gray400,
              fontSize: 8,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //그래프
          Container(
            height: 6,
            width: MediaQuery.of(context).size.width * percent,
            decoration: BoxDecoration(
                color: Palette.green400,
                borderRadius: BorderRadius.circular(5)),
          )
        ],
      ),
    );
  }
}
