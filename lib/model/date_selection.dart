import 'package:flutter/material.dart';

void showCustomDatePicker(BuildContext context, DateTime selectedDate, Function(DateTime) onDateSelected) {
  int selectedMonth = selectedDate.month;
  int selectedDay = selectedDate.day;
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: screenWidth,
            height: screenHeight / 1.8,
            child: AlertDialog(
              title: const Text("選擇日期"),
              content: Row(
                children: [
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      controller: FixedExtentScrollController(initialItem: selectedMonth - 1),
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedMonth = index + 1;
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 12,
                        builder: (context, index) {
                          final isSelected = selectedMonth == index + 1;
                          return Center(
                            child: Text(
                              "${index + 1} 月",
                              style: TextStyle(
                                fontSize: isSelected ? 24 : 18,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      controller: FixedExtentScrollController(initialItem: selectedDay - 1),
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedDay = index + 1;
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 31,
                        builder: (context, index) {
                          final isSelected = selectedDay == index + 1;
                          return Center(
                            child: Text(
                              "${index + 1} 日",
                              style: TextStyle(
                                fontSize: isSelected ? 24 : 18,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("取消", style: TextStyle(fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onDateSelected(DateTime(DateTime.now().year, selectedMonth, selectedDay));
                  },
                  child: const Text("確認", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}