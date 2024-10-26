import 'package:flutter/cupertino.dart';

/// `DatePicker` 위젯을 띄우는 함수
Future<DateTime> showCustomDatePicker(
  BuildContext context,
  DateTime selectedDate,
) async {
  await showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return DatePicker(
        initialDate: selectedDate,
        onDateSelected: (DateTime date) {
          selectedDate = date;
        },
      );
    },
  );

  return selectedDate;
}

class DatePicker extends StatelessWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: CupertinoColors.systemBackground,
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              onDateTimeChanged: onDateSelected,
            ),
          ),
          CupertinoButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context); // 모달 닫기
            },
          ),
        ],
      ),
    );
  }
}
