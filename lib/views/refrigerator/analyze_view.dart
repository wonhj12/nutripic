import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/refrigerator/analyze_view_model.dart';
import 'package:provider/provider.dart';

class AnalyzeView extends StatelessWidget {
  const AnalyzeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<AnalyzeViewModel>();

    return CustomScaffold(
      canPop: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 텍스트
            Text('분석 중입니다',
                style: Palette.title2Medium.copyWith(
                  color: Palette.green600,
                )),
            const SizedBox(height: 20),

            // 로딩
            const SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                color: Palette.gray200,
                backgroundColor: Palette.gray100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
