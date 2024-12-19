import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/food_tile.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingViewModel onboardingViewModel =
        context.watch<OnboardingViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(
        backButton: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              Positioned(
                bottom: -7,
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  color: Palette.primary,
                ),
              ),
              // Text
              const Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  '알레르기가',
                  style: Palette.heading,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Positioned(
                bottom: -7,
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  color: Palette.primary,
                ),
              ),
              // Text
              const Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  '있는 식품이 있나요?',
                  style: Palette.heading,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: onboardingViewModel.allergies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return FoodTile(
                  food: onboardingViewModel.allergies[index],
                  isSelected: onboardingViewModel.selectedAllergies
                      .contains(onboardingViewModel.allergies[index]),
                  isSelectable: true,
                  select: onboardingViewModel.selectAllergies,
                  showInfo: false,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Palette.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text(
            "완료",
            style: Palette.subtitle,
          ),
        ),
      ),
    );
  }
}
