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
      height: 96,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Palette.gray100,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //그래프
          Stack(
            alignment: Alignment.center,
            children: [
              // 원형 그래프
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: CircularProgressIndicator(
                  value: percent,
                  strokeCap: StrokeCap.round,
                  strokeWidth: 10,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    type.color,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    (percent * 100).toStringAsFixed(1),
                    style: TextStyle(
                      color: type.color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "%",
                    style: TextStyle(
                      color: type.color,
                      fontSize: 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ],
          ),

          //문구
          Text(
            '$totalDays일 중 $diaryDays일을\n건강하게 식사했습니다!',
            style: Palette.caption,
          ),
        ],
      ),
    );
  }
}
