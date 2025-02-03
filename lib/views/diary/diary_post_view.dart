import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/diary/calendar_scaffold.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryPostView extends StatefulWidget {
  const DiaryPostView({super.key});

  @override
  State<DiaryPostView> createState() => _DiaryPostViewState();
}

class _DiaryPostViewState extends State<DiaryPostView> {
  @override
  Widget build(BuildContext context) {
    DiaryPostViewModel diaryPostViewModel = context.watch<DiaryPostViewModel>();

    return CalendarScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // 사진
                  diaryPostViewModel.imageUrl == null
                      ? GestureDetector(
                          onTap: () => diaryPostViewModel.selectFromAlbum(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Palette.gray50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Palette.gray100,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/image.svg',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "이미지 업로드",
                                  style: TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                          ))
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(diaryPostViewModel.imageUrl!),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover, // 이미지를 컨테이너에 맞춤
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Palette.gray100.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: IconButton(
                                  onPressed: () =>
                                      diaryPostViewModel.selectFromAlbum(),
                                  icon: SvgPicture.asset(
                                    'assets/icons/image.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20),
                  // 시간 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: DiaryPostViewModel.diaryTime.map((time) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: GestureDetector(
                          onTap: () {
                            diaryPostViewModel.selectTime(time);
                          },
                          child: Container(
                            height: 31,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: diaryPostViewModel.isSelected(time)
                                  ? Palette.green500
                                  : Colors.transparent, // 선택된 버튼 색상
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: diaryPostViewModel.isSelected(time)
                                    ? Palette.green500
                                    : Palette.gray200, // 테두리 색상
                                width: 1,
                              ),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                color: diaryPostViewModel.isSelected(time)
                                    ? Palette.gray00
                                    : Palette.gray300,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // 게시글
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.width -
                            330, // 남은 화면 크기 계산
                      ),
                      child: TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: '메모 작성하기..',
                          hintStyle: TextStyle(color: Palette.gray300),
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                          filled: true,
                        ),
                        style: const TextStyle(fontSize: 8),
                        textInputAction: TextInputAction.done,
                        onChanged: (text) {
                          diaryPostViewModel.updateInputText(text); // 입력값 동기화
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // 게시 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: diaryPostViewModel.isPostable
                          ? () => diaryPostViewModel.submitPost(context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Palette.green500,
                        disabledBackgroundColor: Palette.gray100,
                      ),
                      child: Text(
                        '등록',
                        style: TextStyle(
                          fontSize: 10,
                          color: diaryPostViewModel.isPostable
                              ? Colors.white // 활성화된 색상
                              : Palette.gray400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      isCalendarVisible: diaryPostViewModel.isCalendarVisible,
      selectedDateString: diaryPostViewModel.selectedDateString(),
      onTapCalenderVisible: diaryPostViewModel.onTapCalenderVisible,
      selectedDate: diaryPostViewModel.selectedDate,
      focusedDay: diaryPostViewModel.focusedDay,
      updateFocusedDay: diaryPostViewModel.updateFocusedDay,
      updateSelectedDate: diaryPostViewModel.updateSelectedDate,
    );
  }
}
