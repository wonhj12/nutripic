import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/components/custom_scaffold.dart';
import 'package:nutripic/view_models/diary/diary_post_view_model.dart';
import 'package:provider/provider.dart';

class DiaryPostView extends StatefulWidget {
  const DiaryPostView({super.key});

  @override
  State<DiaryPostView> createState() => _DiaryPostViewState();
}

class _DiaryPostViewState extends State<DiaryPostView> {
  @override
  Widget build(BuildContext context) {
    DiaryPostViewModel diaryPostViewModel = context.watch<DiaryPostViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 사진
            GestureDetector(
              onTap: () => diaryPostViewModel.showCameraSelectModal(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(diaryPostViewModel.diaryModel.diary!.imageUrl!),
                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 게시글
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(
                    0xFFEDFFF8), // Background color of the container
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: const Color(
                        0xFF77D4B1)), // Border color of the container
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => diaryPostViewModel.onTapTimePicker(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 13, top: 13), // Adds space to the left
                      child: Text(
                        diaryPostViewModel.selectedDateString(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF002C1C),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: '메모하기',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF689383),
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                    ),
                    style: const TextStyle(
                        color: Colors.black), // Text color inside the field
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),

            // 게시 버튼
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => diaryPostViewModel.submitPost(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('게시', style: TextStyle(fontSize: 15)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
