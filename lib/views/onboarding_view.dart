import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
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
                  color: Palette.green700,
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
                  color: Palette.green700,
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
            height: 30,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: onboardingViewModel.allergies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 4.4,
              ),
              itemBuilder: (context, index) {
                final allergy = onboardingViewModel.allergies[index];
                final isSelected =
                    onboardingViewModel.isAllergySelected(allergy);

                return GestureDetector(
                  onTap: () {
                    onboardingViewModel.selectAllergies(allergy);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Palette.green500 : Palette.gray200,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      onboardingViewModel.allergies[index],
                      style: TextStyle(
                        color: isSelected ? Palette.green500 : Palette.gray200,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: TextButton(
          onPressed: () {
            context.go('/refrigerator');
          },
          style: TextButton.styleFrom(
            backgroundColor: Palette.green700,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text(
            "완료",
            style: Palette.subtitle1Medium,
          ),
        ),
      ),
    );
  }
}
