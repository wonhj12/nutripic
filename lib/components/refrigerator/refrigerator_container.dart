import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/food_tile.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RefrigeratorContainer extends StatelessWidget {
  /// 전체 식재료 리스트
  final List<Food> foods;

  /// 선택된 식재료 set (중복 방지)
  final Set<Food> selectedFoods;

  /// 식재료 선택 가능 여부
  final bool isSelectable;

  /// 새로운 식재로 추가
  final Function()? addFood;

  /// 식재료 선택시 콜백 함수
  final Function(Food) selectFood;
  const RefrigeratorContainer({
    super.key,
    required this.foods,
    required this.selectedFoods,
    required this.isSelectable,
    required this.addFood,
    required this.selectFood,
  });

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [Palette.shadow],
        ),
        child: foods.isEmpty
            // 식재료 리스트가 없으면 추가 버튼 생성
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: addFood,
                      icon: const Icon(
                        Icons.add_circle_rounded,
                        size: 56,
                        color: Palette.sub,
                      ),
                    ),
                    const Text('식재료를 추가해보세요', style: Palette.body),
                  ],
                ),
              )
            // 식재료 리스트가 있으면 GridView 생성
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller,
                      physics: const ClampingScrollPhysics(),
                      itemCount: (foods.length / 9).ceil(),
                      itemBuilder: (context, pageIndex) {
                        // 현제 페이지의 시작 index
                        final int startIndex = pageIndex * 9;
                        // 현제 페이지의 마지막 식재료 index
                        // foods.length가 최대 크기
                        final int endIndex =
                            (startIndex + 9).clamp(0, foods.length);

                        return GridView.builder(
                          itemCount: endIndex - startIndex,
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 10,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 22,
                            crossAxisCount: 4,
                            childAspectRatio: 64 / 84,
                          ),
                          itemBuilder: (context, gridIndex) {
                            // 식재료 최종 index
                            final foodIndex = startIndex + gridIndex;

                            return FoodTile(
                              food: foods[foodIndex],
                              isSelected:
                                  selectedFoods.contains(foods[foodIndex]),
                              isSelectable: isSelectable,
                              showDday: foods[foodIndex].showDday(),
                              select: selectFood,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // 페이지 indicator
                  SmoothPageIndicator(
                    controller: controller,
                    count: (foods.length / 9).ceil(),
                    effect: const WormEffect(
                      dotWidth: 5,
                      dotHeight: 5,
                      dotColor: Palette.gray100,
                      activeDotColor: Palette.sub,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
      ),
    );
  }
}
