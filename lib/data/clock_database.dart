import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmClockProvider with ChangeNotifier {
  List<Map<String, dynamic>> _clockData = [];

  List<Map<String, dynamic>> get clockData => _clockData;

  final _dataBox = Hive.box('dataBox');

  void loadInitialData() {
    if (_dataBox.get("clockList") == null) {
      _clockData = [
        {
          "Day": "0616",
          "Time": "08:30",
          "subtitle": "買東西",
          "volume": 70,
          "sleepInMIN": 5,
          "sleepInAttempt": 5,
          "volumeTurnOn": false,
          "isON": false
        },
        {
          "Day": "四",
          "Time": "08:30",
          "subtitle": "買東西",
          "volume": 70,
          "sleepInMIN": 5,
          "sleepInAttempt": 5,
          "volumeTurnOn": false,
          "isON": false
        }
      ];
    } else {
      final rawList = _dataBox.get("clockList") as List;
      _clockData = rawList.map((item) => Map<String, dynamic>.from(item as Map)).toList();
    }
    notifyListeners();
  }

  void addClock(Map<String, dynamic> newClock) {
    _clockData.add(newClock);
    saveToLocal();
    notifyListeners();
  }

  void toggleSwitch(int index, bool value) {
    _clockData[index]["isON"] = value;
    saveToLocal();
    notifyListeners();
  }

  void saveToLocal() {
    _dataBox.put("clockList", _clockData);
  }

  void updateClock(int index, Map<String, dynamic> updatedClock) {
    _clockData[index] = updatedClock;
    saveToLocal();
    notifyListeners();
  }

  void deleteClock(int index) {
    _clockData.removeAt(index);
    saveToLocal();
    notifyListeners();
  }
}