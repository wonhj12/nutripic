import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeTile extends StatelessWidget {
  /// 식재료
  final Recipe recipe;

  /// 좋아요 토글 함수
  final Function() like;

  /// 타일 탭 함수
  final Function() onTap;

  const RecipeTile({
    super.key,
    required this.recipe,
    required this.like,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(recipe.imageUrl),
      ),
      title: Text(
        recipe.name,
        style: Palette.subtitle1Medium,
      ),
      subtitle: Row(
        children: [
          Row(
            children: List.generate(3, (starIndex) {
              return Icon(
                starIndex < recipe.difficulty ? Icons.star : Icons.star_border,
                color: Palette.green600,
                size: 15, // 별 크기
              );
            }),
          ),
          const SizedBox(
            width: 10, //추후 수정 필요
          ),
          Text(
            '${recipe.cookingTime}분 이내',
            style: Palette.caption1.copyWith(
              color: Palette.success,
            ),
          )
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.favorite,
          color: recipe.isFavorite ? Palette.green500 : Palette.gray200,
        ),
        onPressed: like,
      ),
      onTap: onTap,
    );
  }
}
