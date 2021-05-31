// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DemoModelAdapter extends TypeAdapter<DemoModel> {
  @override
  final int typeId = 0;

  @override
  DemoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DemoModel()
      .._name = fields[0] as String
      .._country = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, DemoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DemoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoModel _$DemoModelFromJson(Map<String, dynamic> json) {
  return DemoModel(
    name: json['name'] as String,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$DemoModelToJson(DemoModel instance) => <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
    };
