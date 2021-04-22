// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item()
      ..title = fields[0] as String
      ..description = fields[1] as String
      ..itemUsed = (fields[2] as List).cast<int>()
      ..createAt = fields[3] as DateTime
      ..updateAt = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.itemUsed)
      ..writeByte(3)
      ..write(obj.createAt)
      ..writeByte(4)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
