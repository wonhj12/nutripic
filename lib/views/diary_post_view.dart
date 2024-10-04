import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/view_models/diary_post_view_model.dart';
import 'package:provider/provider.dart';

class DiaryPostView extends StatefulWidget {
  final String imagePath;
  const DiaryPostView({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<DiaryPostView> createState() => _DiaryPostViewState();
}

class _DiaryPostViewState extends State<DiaryPostView> {
  @override
  Widget build(BuildContext context) {
    DiaryPostViewModel diaryPostViewModel = context.watch<DiaryPostViewModel>();

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: '새로운 게시물'),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.file(
              File(widget.imagePath),
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
