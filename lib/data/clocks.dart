import 'package:hive_flutter/hive_flutter.dart';
part 'clocks.g.dart';

@HiveType(typeId: 1)
class Clocks
{
  @HiveField(0)
  String Day;
  @HiveField(1)
  String Time;
  @HiveField(2)
  String Subtitle;
  @HiveField(3)
  int volume;
  @HiveField(4)
  int sleepInMIN;
  @HiveField(5)
  int sleepInAttempt;
  @HiveField(6)
  bool volumeTurnOn;
  @HiveField(7)
  bool isON;

  @HiveField(8)
  Clocks(
      {
        required this.Day,
        required this.Time,
        required this.Subtitle,
        required this.volume,
        required this.sleepInMIN,
        required this.sleepInAttempt,
        required this.volumeTurnOn,
        required this.isON,
      });
}