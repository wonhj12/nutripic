import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutripic/view_models/diary_camera_view_model.dart';
import 'package:provider/provider.dart';

class DiaryCameraView extends StatefulWidget {
  const DiaryCameraView({super.key});

  @override
  State<DiaryCameraView> createState() => _DiaryCameraViewState();
}

class _DiaryCameraViewState extends State<DiaryCameraView> {
  @override
  Widget build(BuildContext context) {
    DiaryCameraViewModel diaryCameraViewModel =
        context.watch<DiaryCameraViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20.0,
              ),
              const Text(
                "올리기",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              IconButton(
                onPressed: () {
                  diaryCameraViewModel.closeCameraSelectModal(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 33.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  diaryCameraViewModel.getImage(ImageSource.camera, context);
                  if (diaryCameraViewModel.image != null) {
                    // 카메라에서 이미지가 선택되면 새로운 화면으로 전환
                  }
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 50.0,
                    ),
                    Text(
                      "카메라",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  diaryCameraViewModel.getImage(ImageSource.gallery, context);
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.photo_library,
                      size: 50.0,
                    ),
                    Text(
                      "갤러리",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
