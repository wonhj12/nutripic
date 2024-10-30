import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

enum StatusType {
  //색 바꾸기
  low(Colors.red),
  normal(Palette.sub);

  final Color color;
  const StatusType(this.color);
}

class DiarySummaryContainer extends StatelessWidget {
  final double percent;
  final StatusType type;
  final int totalDays;
  final int diaryDays;

  const DiarySummaryContainer({
    super.key,
    required this.percent,
    this.type = StatusType.normal,
    required this.totalDays,
    required this.diaryDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Palette.primary,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),

          //그래프
          Stack(
            alignment: Alignment.center,
            children: [
              // 원형 그래프
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Palette.white,
                  shape: BoxShape.circle,
                ),
                child: CircularProgressIndicator(
                  value: percent,
                  strokeCap: StrokeCap.round,
                  strokeWidth: 10,
                  backgroundColor: Palette.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    type.color,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                crossAxisAlignment: CrossAxisAlignment.baseline, // 기준선 정렬
                textBaseline: TextBaseline.alphabetic, // 텍스트 기준선
                children: [
                  Text(
                    (percent * 100).toStringAsFixed(1), // 큰 텍스트
                    style: TextStyle(
                      color: type.color,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "%", // 작은 텍스트
                    style: TextStyle(
                      color: type.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),

          //문구
          Text(
            '$totalDays일 중 $diaryDays일을\n건강하게 식사했습니다!',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
