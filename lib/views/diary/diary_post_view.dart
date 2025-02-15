import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/diary/calendar_scaffold.dart';
import 'package:nutripic/components/common/main_button.dart';
import 'package:nutripic/utils/enums/main_button_type.dart';
import 'package:nutripic/utils/palette.dart';
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
    TextEditingController textController =
        TextEditingController(text: diaryPostViewModel.inputText);

    return CalendarScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // 이미지 업로드
                  diaryPostViewModel.imageUrl == null
                      ? GestureDetector(
                          onTap: () => diaryPostViewModel.selectFromAlbum(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Palette.gray50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
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
                                Text(
                                  '이미지 업로드',
                                  style: Palette.subtitle2SemiBold
                                      .copyWith(color: Palette.gray700),
                                ),
                              ],
                            ),
                          ))
                      : Stack(
                          children: [
                            // 선택한 이미지
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(diaryPostViewModel.imageUrl!),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // 다른 사진 선택 버튼
                            if (!diaryPostViewModel.isPatch)
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
                    children: List.generate(
                        diaryPostViewModel.mealTimeList.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: GestureDetector(
                          onTap: () => diaryPostViewModel.onTapMealTime(index),
                          child: Container(
                            height: 31,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: diaryPostViewModel.mealTime == index
                                  ? Palette.green500
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: diaryPostViewModel.mealTime == index
                                    ? Palette.green500
                                    : Palette.gray200,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              diaryPostViewModel.mealTimeList[index],
                              style: Palette.body1.copyWith(
                                color: diaryPostViewModel.mealTime == index
                                    ? Palette.gray00
                                    : Palette.gray300,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // 게시글
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      maxLines: null,
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: '메모 작성하기...',
                        hintStyle:
                            Palette.body1.copyWith(color: Palette.gray300),
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        filled: true,
                      ),
                      style: Palette.body1.copyWith(color: Palette.gray900),
                      textInputAction: TextInputAction.done,
                      onChanged: (text) {
                        diaryPostViewModel.updateInputText(text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      isCalendarVisible: diaryPostViewModel.isCalendarVisible,
      onTapCalenderVisible: diaryPostViewModel.onTapCalenderVisible,
      selectedDay: diaryPostViewModel.selectedDay!,
      focusedDay: diaryPostViewModel.focusedDay,
      updateFocusedDay: diaryPostViewModel.updateFocusedDay,
      updateSelectedDate: diaryPostViewModel.updateSelectedDay,
      isPatch: diaryPostViewModel.isPatch,

      // 게시글 등록 버튼
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 23),
        width: double.infinity,
        height: 85,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              color: Palette.gray100,
              width: 1,
            ),
          ),
        ),
        child: MainButton(
          label: '등록',
          type: diaryPostViewModel.isPost
              ? MainButtonType.enabled
              : MainButtonType.disabled,
          onPressed: diaryPostViewModel.isPost
              ? () => {
                    diaryPostViewModel.isPatch
                        ? diaryPostViewModel.updatePost(context)
                        : diaryPostViewModel.submitPost(context)
                  }
              : null,
        ),
      ),
    );
  }
}
