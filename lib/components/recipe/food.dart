import 'package:flutter/widgets.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:flutter_svg/svg.dart';

class Food extends StatelessWidget {
  const Food({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [Palette.shadow],
      ),
      child: SvgPicture.asset(
        width: 34,
        'assets/foods/carrot.svg',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
