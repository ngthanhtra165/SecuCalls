// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spam_number.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MySpamNumberAdapter extends TypeAdapter<MySpamNumber> {
  @override
  final int typeId = 1;

  @override
  MySpamNumber read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MySpamNumber(
      (fields[0] as List).cast<String>(),
      (fields[1] as List).cast<String>(),
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MySpamNumber obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MySpamNumberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
