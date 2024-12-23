import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/diary/diary_card.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';
import 'package:provider/provider.dart';

class DiaryRecordView extends StatelessWidget {
  const DiaryRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryRecordViewModel diaryRecordViewModel =
        context.watch<DiaryRecordViewModel>();
    if (!diaryRecordViewModel.isLoading &&
        diaryRecordViewModel.todayDiaries.isEmpty) {
      diaryRecordViewModel.getDiaryRecord();
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go('/diary/post',
                  extra: diaryRecordViewModel.selectedDate);
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
          onPressed: () {
            context.go('/diary');
          },
        ),
        title: Text(
          diaryRecordViewModel.selectedDateString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: diaryRecordViewModel.todayDiaries.length,
        itemBuilder: (context, index) {
          final diary = diaryRecordViewModel.todayDiaries[index];
          return DiaryCard(
            diary: diary,
            onPressed: () =>
                diaryRecordViewModel.showOptionModal(diary.diaryId!),
          );
        },
      ),
    );
  }
}
