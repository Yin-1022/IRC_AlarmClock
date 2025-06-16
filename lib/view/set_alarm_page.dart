import 'package:flutter/material.dart';
import '../model/date_selection.dart';
import 'package:provider/provider.dart';

class AlarmClockProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _clockData = [];

  List<Map<String, dynamic>> get clockData => _clockData;

  void addClock(Map<String, dynamic> newClock) {
    _clockData.add(newClock);
    notifyListeners(); // 通知畫面更新
  }

  void toggleSwitch(int index, bool value) {
    _clockData[index]["isON"] = value;
    notifyListeners();
  }
}

void showAlarmEditDialog(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  TextEditingController intervalController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  String mode = "weekly";
  int selectedIndex = 3;
  int volumeLevel = 7;
  bool increaseVolume = false;
  DateTime now = DateTime.now();
  DateTime selectedDate = now;
  DateTime defaultTime = now.add(const Duration(hours: 3));
  int selectedHour = defaultTime.hour;
  int selectedMinute = defaultTime.minute;
  final hourController = FixedExtentScrollController(initialItem: 1000 + selectedHour);
  final minuteController = FixedExtentScrollController(initialItem: 1000 + selectedMinute);

  showDialog(
    context: context,
    builder: (context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final weekdays = ['日', '一', '二', '三', '四', '五', '六'];
      final pageController = PageController(viewportFraction: 0.3, initialPage: 1000 + selectedIndex);

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight / 1.62,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// 顯示日期或星期選擇器
                    Column(
                      children: [
                        Visibility(
                          visible: mode == "daily",
                          child: GestureDetector(
                            onTap: () {
                              showCustomDatePicker(context, selectedDate, (pickedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              });
                            },
                            child: Container(
                              color: Colors.grey,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              child: Text(
                                "${selectedDate.month.toString().padLeft(2, '0')} / ${selectedDate.day.toString().padLeft(2, '0')}",
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: mode == "weekly",
                          child: SizedBox(
                            height: 51,
                            child: PageView.builder(
                              controller: pageController,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (int index) {
                                setState(() {
                                  selectedIndex = index % 7;
                                });
                              },
                              itemBuilder: (context, index) {
                                int dayIndex = index % 7;
                                bool isCenter = (pageController.page?.round() ?? pageController.initialPage) == index;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isCenter ? Colors.blue[100] : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      weekdays[dayIndex],
                                      style: TextStyle(
                                        fontSize: isCenter ? 24 : 18,
                                        fontWeight: isCenter ? FontWeight.bold : FontWeight.normal,
                                        color: isCenter ? Colors.blue[900] : Colors.black54,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// 時間顯示 (假設固定值)
                        Container(
                          width: screenWidth / 1.8,
                          height: screenHeight / 12,
                          color: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListWheelScrollView.useDelegate(
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 1.2,
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      selectedHour = index % 24;
                                    });
                                  },
                                  controller: hourController,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      final hour = index % 24;
                                      return Center(
                                        child: Text(
                                          hour.toString().padLeft(2, '0'),
                                          style: const TextStyle(fontSize: 40, color: Colors.black),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const VerticalDivider(color: Colors.white, thickness: 1.4),
                              Expanded(
                                child: ListWheelScrollView.useDelegate(
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 1.2,
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      selectedMinute = index % 60;
                                    });
                                  },
                                  controller: minuteController,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      final minute = index % 60;
                                      return Center(
                                        child: Text(
                                          minute.toString().padLeft(2, '0'),
                                          style: const TextStyle(fontSize: 40, color: Colors.black),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Name
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text("名稱: ", style: TextStyle(fontSize: 18)),
                            Expanded(
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// Volume
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("音量: ", style: TextStyle(fontSize: 18)),
                            Expanded(
                              child: Row(
                                children: List.generate(10, (i) {
                                  return Ink(
                                    child: InkWell(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 2),
                                        width: 15,
                                        height: 27,
                                        color: i < volumeLevel ? Colors.green : Colors.grey,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          volumeLevel = i + 1;
                                        });
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// Mode
                        Row(
                          children: [
                            const Text("模式: ", style: TextStyle(fontSize: 18)),
                            Row(
                              children: [
                                Radio(
                                  value: "weekly",
                                  groupValue: mode,
                                  onChanged: (value) {
                                    setState(() {
                                      mode = value.toString();
                                    });
                                  },
                                ),
                                const Text("當日", style: TextStyle(fontSize: 18)),
                                Radio(
                                  value: "daily",
                                  groupValue: mode,
                                  onChanged: (value) {
                                    setState(() {
                                      mode = value.toString();
                                    });
                                  },
                                ),
                                const Text("每週", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ],
                        ),

                        /// 賴床設定
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("賴床： 每隔 ", style: TextStyle(fontSize: 18)),
                                SizedBox(
                                  width: 40,
                                  child: TextField
                                    (
                                      controller: intervalController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        final intValue = int.tryParse(value);
                                        if (intValue != null && intValue > 60) {
                                          intervalController.text = '60';
                                          intervalController.selection = TextSelection.fromPosition(
                                            const TextPosition(offset: 2),
                                          );
                                        }
                                      },
                                    ),
                                ),
                                const Text(" 分鐘 叫一次", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text("共叫 ", style: TextStyle(fontSize: 18)),
                                      SizedBox(
                                        width: 40,
                                        child: TextField
                                        (
                                          controller: repeatController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            final intValue = int.tryParse(value);
                                            if (intValue != null && intValue > 10) {
                                              repeatController.text = '10';
                                              repeatController.selection = TextSelection.fromPosition(
                                                const TextPosition(offset: 2),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      const Text(" 次", style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: increaseVolume,
                                        onChanged: (val) {
                                          setState(() {
                                            increaseVolume = val ?? false;
                                          });
                                        },
                                      ),
                                      const Text("每次音量提升", style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// 音樂選擇
                        Row(
                          children: [
                            const Text("音樂： ", style: TextStyle(fontSize: 18)),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                color: Colors.grey,
                                child: const Text("", style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            const Icon(Icons.share),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("取消", style: TextStyle(fontSize: 18)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, );
                            setState((){
                              final realHour = hourController.selectedItem % 24;
                              final realMinute = minuteController.selectedItem % 60;
                              final scheduledTime = DateTime(
                                selectedDate.month,
                                selectedDate.day,
                                realHour,
                                realMinute,
                              );

                              if (mode == "daily" && scheduledTime.isBefore(DateTime.now())) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text("請選擇未來的日期與時間",style: TextStyle(fontSize: 30),)),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                return;
                              }

                              Provider.of<AlarmClockProvider>(context, listen: false).addClock({
                              "Day" : mode == "weekly" ? (selectedIndex == 3 ? weekdays[selectedIndex-1] : weekdays[selectedIndex]) : "${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}",
                              "Time": "${realHour.toString().padLeft(2, '0')}:${realMinute.toString().padLeft(2, '0')}",
                              "subtitle": nameController.text.isEmpty ? "" : nameController.text,
                              "volume" : volumeLevel.toInt(),
                              "sleepInMIN" : intervalController.text.isEmpty ? 5 : intervalController.text,
                              "sleepInAttempt" : repeatController.text.isEmpty ? 3 : repeatController.text,
                              "volumeTurnOn" : increaseVolume,
                              "isON" : true
                            });});
                          },
                          child: const Text("送出", style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}


