import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class SearchTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  const SearchTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(children: [
          const Icon(Icons.search_rounded, color: Palette.gray400),
          const SizedBox(width: 12),
          Text(title, style: Palette.body1)
        ]),
      ),
    );
  }
}
