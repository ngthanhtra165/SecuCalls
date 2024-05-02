// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_number_call_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyNumberCallLogAdapter extends TypeAdapter<MyNumberCallLog> {
  @override
  final int typeId = 0;

  @override
  MyNumberCallLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyNumberCallLog(
      fields[0] as String,
      fields[1] as CallType,
      fields[2] as CallType,
    );
  }

  @override
  void write(BinaryWriter writer, MyNumberCallLog obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cachedMatchedNumber)
      ..writeByte(1)
      ..write(obj.callType)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyNumberCallLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
