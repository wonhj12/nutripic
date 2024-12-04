import 'package:flutter/material.dart';

class SavedRecipeTile extends StatelessWidget {
  final String name;
  final String time;
  final String difficulty;
  const SavedRecipeTile({
    super.key,
    required this.name,
    required this.time,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 182,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 레시피 이름
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          // 레시피 정보
          Row(
            children: [
              // 요리 시간
              Text(
                time,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              const SizedBox(width: 10),

              // 요리 난이도
              Text(
                difficulty,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
