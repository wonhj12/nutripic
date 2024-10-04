import 'package:flutter/material.dart';
import 'package:nutripic/view_models/diary_post_view_model.dart';
import 'package:provider/provider.dart';

class DiaryPostView extends StatefulWidget {
  const DiaryPostView({super.key, String? imagePath});

  @override
  State<DiaryPostView> createState() => _DiaryPostViewState();
}

class _DiaryPostViewState extends State<DiaryPostView> {
  @override
  Widget build(BuildContext context) {
    DiaryPostViewModel diaryPostViewModel = context.watch<DiaryPostViewModel>();

    return const Placeholder();
  }
}
