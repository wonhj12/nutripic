import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/utils/api.dart';
import 'package:path/path.dart' as path;

class DiaryPostViewModel with ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;
  String? imageUrl;
  bool isPatch = false;

  DiaryPostViewModel({
    required this.diaryModel,
    required this.context,
    required this.selectedDate,
    this.imageUrl,
    this.diaryId,
    this.existingText,
  }) {
    getDiary();
  }

  final ImagePicker _picker = ImagePicker();

  // 해당 날짜 선택
  DateTime selectedDate;
  DateTime focusedDay = DateTime.now();
  bool isCalendarVisible = false;

  // 시간 선택
  static List<String> diaryTime = ["아침", "점심", "저녁", "간식", "기타"]; // 버튼 리스트
  String? selectedTime;
  bool timeSelected = true;

  // 게시글
  String inputText = "";
  bool isPostable = false;
  String? fileName;

  final int? diaryId;
  String? existingText = "";

  /// 카메라/갤러리 선택 모달
  // void showCameraSelectModal() async {
  //   // 모달 띄워서 사진 업로드 방식 선택 (카메라, 갤러리)
  //   final mode = await selectCameraModal(context);

  //   // 선택된
  //   if (mode != null) {
  //     // 이미지 촬영 / 갤러리에서 이미지 불러오기
  //     final pickedFile = await _picker.pickImage(source: mode);

  //     // 사진 촬영 완료 후 diary에 사진 경로 업데이트
  //     // TODO: 기존 경로에 있는 사진을 제거하는 로직 추가 필요
  //     if (pickedFile != null) {
  //       final image = File(pickedFile.path);
  //       diaryModel.diary!.imageUrl = image.path;
  //       notifyListeners();
  //     }
  //   }
  // }

  Future<void> getDiary() async {
    if (diaryId == null) return;

    try {
      final response = await API.getDiaryById(diaryId!);
      isPatch = true;
      imageUrl = response['url'];
      selectedDate = DateTime.parse(response['date']);
      existingText = response['body'];
      print(existingText);
      notifyListeners();
    } catch (e) {
      print("다이어리 불러오기 실패: $e");
    }
  }

  /// 시간이 선택되었는지 확인하는 함수
  bool isSelected(String time) {
    return selectedTime == time;
  }

  //시간 선택 함수
  void selectTime(String time) {
    if (selectedTime == time) {
      selectedTime = null;
      timeSelected = false;
    } else {
      selectedTime = time;
      timeSelected = true;
    }
    notifyListeners();
    checkPostable();
  }

  /// 이미지 선택 함수
  Future<void> selectFromAlbum() async {
    // 모달 띄워서 사진 업로드 방식 선택 (카메라, 갤러리)
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    // 사진 촬영 완료 후 diary에 사진 경로 업데이트
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      //diaryModel.diary!.imageUrl = image.path;
      imageUrl = image.path;
      fileName = path.basename(pickedFile.path);
      notifyListeners();
      checkPostable();
    }
  }

  /// 캘린더 표시 함수
  void onTapCalenderVisible() async {
    isCalendarVisible = !isCalendarVisible;
    notifyListeners();
  }

  /// 입력된 메모 업데이트
  void updateInputText(String text) {
    inputText = text;
    checkPostable(); // 게시 가능 여부 갱신
  }

  /// 게시 가능 여부 함수
  void checkPostable() async {
    //글은 없이 올리고 싶을수도 있자나>
    bool newPostable = imageUrl != null && timeSelected == true;
    if (isPostable != newPostable) {
      isPostable = newPostable;
      notifyListeners();
    }
  }

  /// 선택된 날짜를 String 형식으로 반환하는 함수
  // 날짜 형식 변환 관련 함수는 아마 나중에 utils에 따로 만들지 않을까 싶긴 합니다.
  String selectedDateString() {
    return '${selectedDate.month}월 ${selectedDate.day}일';
  }

  ///선택 날짜 변경 함수
  void updateSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    notifyListeners();
  }

  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    notifyListeners();
  }

  /// 게시물 전송
  Future<void> submitPost(BuildContext context) async {
    try {
      String presignedUrl = await API.getImgPresignedURL(fileName!);

      await API.addDiary(
        inputText,
        selectedDate,
        presignedUrl,
      );

      if (context.mounted) context.pop();
    } catch (e) {
      debugPrint("게시물 추가 실패: $e");
    }
  }

  /// 게시물 수정
  Future<void> updatePost(BuildContext context) async {
    try {
      await API.updateDiary(
        diaryId!,
        inputText,
        selectedDate,
      );
      debugPrint("게시물 수정 성공: " + inputText);

      if (context.mounted) context.pop();
    } catch (e) {
      debugPrint("게시물 수정 실패: $e");
    }
  }
}
