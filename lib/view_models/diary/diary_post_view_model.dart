import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/utils/api.dart';

class DiaryPostViewModel with ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;

  DiaryPostViewModel({
    required this.diaryModel,
    required this.context,
    required this.selectedDay,
    this.imageUrl,
    this.diaryId,
  }) {
    getDiary();
  }

  /// 게시 가능 여부
  bool isPost = false;

  /// 앨범에서 사진 선택
  final ImagePicker _picker = ImagePicker();

  /// 선택한 이미지 url
  String? imageUrl;

  /// 최초 등록인지 수정 상태인지 확인
  bool isPatch = false;

  /// 사용자가 보고 있는 날짜
  DateTime focusedDay = DateTime.now();

  /// 사용자가 선택한 날짜
  DateTime? selectedDay;

  /// 캘린더 표시 여부
  bool isCalendarVisible = false;

  /// 선택 가능한 시간 리스트
  List<String> mealTimeList = ["아침", "점심", "저녁", "간식", "기타"];

  /// 현재 선택된 시간 index
  int mealTime = -1;

  // 게시글
  String inputText = "";

  /// 이미지 파일 경로
  String? fileName;

  /// 수정 상태 일 때 다이어리 번호
  int? diaryId;

  /// 게시 가능 확인 함수
  void checkPost() async {
    bool check = imageUrl != null && mealTime != -1 && inputText != "";
    if (isPost != check) {
      isPost = check;
      notifyListeners();
    }
  }

  /// 수정 상태일 때 다이어리 불러오는 함수
  Future<void> getDiary() async {
    if (diaryId == null) return;

    await diaryModel.getDiary(diaryId!);
    isPatch = true;
    imageUrl = diaryModel.diary!.url;
    selectedDay = diaryModel.diary!.date!;
    inputText = diaryModel.diary!.body!;
    notifyListeners();
  }

  /// 이미지 선택 함수
  Future<void> selectFromAlbum() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      imageUrl = image.path;
      //fileName = path.basename(pickedFile.path);
      notifyListeners();
      checkPost();
    }
  }

  //시간 선택 함수
  void onTapMealTime(int idx) {
    if (mealTime == idx) {
      mealTime = -1;
    } else {
      mealTime = idx;
    }
    notifyListeners();
    checkPost();
  }

  /// 캘린더 표시 함수
  void onTapCalenderVisible() async {
    isCalendarVisible = !isCalendarVisible;
    notifyListeners();
  }

  /// 입력된 메모 업데이트 함수
  void updateInputText(String text) {
    inputText = text;
    checkPost();
  }

  /// selectedDay 변경 함수
  void updateSelectedDay(DateTime newSelectedDay) {
    selectedDay = newSelectedDay;
    notifyListeners();
  }

  /// focusedDay 변경 함수
  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    notifyListeners();
  }

  /// 게시물 전송
  Future<void> submitPost(BuildContext context) async {
    try {
      //String presignedUrl = await API.getImgPresignedURL(fileName!);

      await API.addDiary(
        inputText,
        selectedDay!,
        imageUrl!,
        mealTime,
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
        selectedDay!,
        mealTime,
      );

      if (context.mounted) context.pop();
    } catch (e) {
      debugPrint("게시물 수정 실패: $e");
    }
  }
}
