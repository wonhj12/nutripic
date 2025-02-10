import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/diary/calendar_scaffold.dart';
import 'package:nutripic/components/diary/diary_card.dart';
import 'package:nutripic/components/diary/diary_dialog.dart';
import 'package:nutripic/components/diary/diary_option_modal.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryRecordView extends StatelessWidget {
  const DiaryRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryRecordViewModel diaryRecordViewModel =
        context.watch<DiaryRecordViewModel>();
    // if (!diaryRecordViewModel.isLoading &&
    //     diaryRecordViewModel.todayDiaries.isEmpty) {
    //   diaryRecordViewModel.getDiaryRecord();
    // }
    return CalendarScaffold(
      body: diaryRecordViewModel.diaryModel.diariesForDay.isEmpty
          ? Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    '등록한 일지가 없어요.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Palette
                          .gray700, // You can choose the color to match your design
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    '식단을 등록하고 기록해 보세요.',
                    style: TextStyle(
                      fontSize: 8,
                      color: Palette
                          .gray400, // You can choose the color to match your design
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 72,
                    height: 32,
                    child: TextButton(
                      onPressed: () =>
                          diaryRecordViewModel.navigateToDiaryPost(),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Palette.gray100,
                      ),
                      child: const Text(
                        "등록하기",
                        style: TextStyle(
                          fontSize: 8,
                          color: Palette.green600,
                        ),
                      ),
                    ),
                  )
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
                            diaryId: diary.diaryId!,
                            onTapPatch: () =>
                                diaryRecordViewModel.onTapPatch(diary.diaryId!),
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
                                              .onTapDelete(diary.diaryId!);
                                        },
                                      ));
                            },
                          )),
                  getTime: diary.mealTime!,
                );
              },
            ),
      isCalendarVisible: diaryRecordViewModel.isCalendarVisible,
      selectedDateString: diaryRecordViewModel.selectedDateString(),
      onTapCalenderVisible: diaryRecordViewModel.onTapCalenderVisible,
      onPressedAdd: diaryRecordViewModel.navigateToDiaryPost,
      selectedDate: diaryRecordViewModel.selectedDate,
      focusedDay: diaryRecordViewModel.focusedDay,
      updateSelectedDate: diaryRecordViewModel.updateSelectedDate,
      updateFocusedDay: diaryRecordViewModel.updateFocusedDay,
      addButton:
          diaryRecordViewModel.diaryModel.diariesForDay.isEmpty ? false : true,
    );
  }
}
