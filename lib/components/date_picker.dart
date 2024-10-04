import 'package:flutter/cupertino.dart';

class DatePicker extends StatelessWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const DatePicker(
      {Key? key, required this.initialDate, required this.onDateSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: Column(
        children: [
          Container(
            height: 180.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              onDateTimeChanged: (DateTime newDate) {
                onDateSelected(newDate); // 선택한 날짜를 부모 위젯에 전달
              },
            ),
          ),
          CupertinoButton(
            child: Text("Done"),
            onPressed: () {
              Navigator.pop(context); // 모달 닫기
            },
          ),
        ],
      ),
    );
  }
}
