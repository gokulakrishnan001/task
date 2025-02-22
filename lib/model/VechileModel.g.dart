// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VechileModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VechileModelAdapter extends TypeAdapter<VechileModel> {
  @override
  final int typeId = 0;

  @override
  VechileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VechileModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VechileModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.vechileName)
      ..writeByte(1)
      ..write(obj.vechileMileage)
      ..writeByte(2)
      ..write(obj.vechileImage)
      ..writeByte(3)
      ..write(obj.vechileAge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VechileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
