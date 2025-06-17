// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clocks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClocksAdapter extends TypeAdapter<Clocks> {
  @override
  final int typeId = 1;

  @override
  Clocks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Clocks(
      Day: fields[0] as String,
      Time: fields[1] as String,
      Subtitle: fields[2] as String,
      volume: fields[3] as int,
      sleepInMIN: fields[4] as int,
      sleepInAttempt: fields[5] as int,
      volumeTurnOn: fields[6] as bool,
      isON: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Clocks obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.Day)
      ..writeByte(1)
      ..write(obj.Time)
      ..writeByte(2)
      ..write(obj.Subtitle)
      ..writeByte(3)
      ..write(obj.volume)
      ..writeByte(4)
      ..write(obj.sleepInMIN)
      ..writeByte(5)
      ..write(obj.sleepInAttempt)
      ..writeByte(6)
      ..write(obj.volumeTurnOn)
      ..writeByte(7)
      ..write(obj.isON);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClocksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
