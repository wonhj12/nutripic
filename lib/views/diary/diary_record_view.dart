import 'package:flutter/material.dart';
import 'package:nutripic/components/box_button.dart';
import 'package:nutripic/components/diary/calendar_scaffold.dart';
import 'package:nutripic/components/diary/diary_card.dart';
import 'package:nutripic/components/diary/diary_dialog.dart';
import 'package:nutripic/components/diary/diary_option_modal.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';
import 'package:provider/provider.dart';

class DiaryRecordView extends StatelessWidget {
  const DiaryRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryRecordViewModel diaryRecordViewModel =
        context.watch<DiaryRecordViewModel>();

    return CalendarScaffold(
      body: diaryRecordViewModel.diaryModel.diariesForDay.isEmpty
          ? Center(
              // 불러올 다이어리 목록이 없는 경우
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    '등록한 일지가 없어요.',
                    style: Palette.caption1.copyWith(color: Palette.gray700),
                    //  TextStyle(
                    //   fontSize: 10,
                    //   color: Palette
                    //       .gray700, // You can choose the color to match your design
                    // ),
                  ),
                  const SizedBox(height: 8),
                  Text('식단을 등록하고 기록해 보세요.',
                      style: Palette.caption2.copyWith(color: Palette.gray400)
                      //  TextStyle(
                      //   fontSize: 8,
                      //   color: Palette
                      //       .gray400, // You can choose the color to match your design
                      // ),
                      ),
                  const SizedBox(height: 30),

                  BoxButton(
                    label: '등록하기',
                    width: 89,
                    type: BoxButtonType.primary,
                    onPressed: diaryRecordViewModel.navigateToDiaryPost,
                  )
                  // SizedBox(
                  //   width: 72,
                  //   height: 32,
                  //   child: TextButton(
                  //     onPressed: diaryRecordViewModel.navigateToDiaryPost,
                  //     style: TextButton.styleFrom(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       backgroundColor: Palette.gray100,
                  //     ),
                  //     child: const Text(
                  //       "등록하기",
                  //       style: TextStyle(
                  //         fontSize: 8,
                  //         color: Palette.green600,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          : ListView.builder(
              itemCount: diaryRecordViewModel.diaryModel.diariesForDay.length,
              itemBuilder: (context, index) {
                final diary =
                    diaryRecordViewModel.diaryModel.diariesForDay[index];
                return DiaryCard(
                  diary: diary,
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => DiaryOptionModal(
                            diaryId: diary.id!,
                            onTapPatch: () {
                              Navigator.pop(context);
                              diaryRecordViewModel.onTapPatch(diary.id!);
                            },
                            onTapDelete: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => DiaryDialog(
                                        onPressedCancel: () {
                                          Navigator.pop(context);
                                        },
                                        onPressedDelete: () {
                                          Navigator.pop(context);
                                          diaryRecordViewModel
                                              .onTapDelete(diary.id!);
                                        },
                                      ));
                            },
                          )),
                  getTime: diaryRecordViewModel.mealTimeList[diary.mealTime!],
                );
              },
            ),
      isCalendarVisible: diaryRecordViewModel.isCalendarVisible,
      onTapCalenderVisible: diaryRecordViewModel.onTapCalenderVisible,
      onPressedAdd: diaryRecordViewModel.navigateToDiaryPost,
      selectedDay: diaryRecordViewModel.selectedDay,
      focusedDay: diaryRecordViewModel.focusedDay,
      updateSelectedDate: diaryRecordViewModel.updateSelectedDay,
      updateFocusedDay: diaryRecordViewModel.updateFocusedDay,
      moveDate: diaryRecordViewModel.getDiaries,
      addButton:
          diaryRecordViewModel.diaryModel.diariesForDay.isEmpty ? false : true,
    );
  }
}
