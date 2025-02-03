import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';

class DiaryCard extends StatelessWidget {
  final Diary diary;
  final Function() onPressed;

  const DiaryCard({super.key, required this.diary, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //프로필사진
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    backgroundColor: Palette.gray300,
                    radius: 18,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //프로필 이름
                      const Text(
                        "닉네임",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        DiaryRecordViewModel.getTime(diary.date!),
                        style: const TextStyle(
                          color: Palette.gray300,
                          fontSize: 6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //게시글 별 메뉴바
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.more_vert,
                  size: 20,
                ),
              )
            ],
          ),

          //사진
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              File(diary.imageUrl!),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              fit: BoxFit.cover, // 이미지를 컨테이너에 맞춤
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //게시글 부분
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            padding: const EdgeInsets.all(11),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: diary.content!.length > 30 ? 70 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Palette.gray100.withOpacity(0.7),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "아침  ",
                    style: TextStyle(
                      // 굵게
                      color: Palette.green700, // 색상 변경
                      fontSize: 10, // 글씨 크기
                    ),
                  ),
                  TextSpan(
                    text: diary.content,
                    style: Palette.caption, // 기존 스타일 사용
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
