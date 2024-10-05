import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final String? src;
  final String name;
  const FoodTile({
    super.key,
    required this.src,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 식재료 사진
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: src != null
              ? ClipOval(
                  child: Image.network(
                    src!,
                    fit: BoxFit.cover,
                    width: 72,
                    height: 72,
                  ),
                )
              : const Icon(Icons.question_mark_rounded, size: 36),
        ),
        const SizedBox(height: 12),

        // 식재료 이름
        Text(name, style: const TextStyle(fontSize: 14))
      ],
    );
  }
}
