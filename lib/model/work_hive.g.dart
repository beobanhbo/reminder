// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkTypeHiveAdapter extends TypeAdapter<WorkTypeHive> {
  @override
  final int typeId = 1;

  @override
  WorkTypeHive read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkTypeHive.DAILY;
      case 1:
        return WorkTypeHive.PLAN;
      default:
        return WorkTypeHive.DAILY;
    }
  }

  @override
  void write(BinaryWriter writer, WorkTypeHive obj) {
    switch (obj) {
      case WorkTypeHive.DAILY:
        writer.writeByte(0);
        break;
      case WorkTypeHive.PLAN:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkTypeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkHiveAdapter extends TypeAdapter<WorkHive> {
  @override
  final int typeId = 0;

  @override
  WorkHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkHive(
      id: fields[0] as String,
      title: fields[1] as String,
      createAt: fields[2] as String,
      stage: fields[3] as int,
      workType: fields[4] as WorkTypeHive,
      workChildMap: (fields[5] as Map)?.cast<String, WorkHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.createAt)
      ..writeByte(3)
      ..write(obj.stage)
      ..writeByte(4)
      ..write(obj.workType)
      ..writeByte(5)
      ..write(obj.workChildMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkBlockHiveAdapter extends TypeAdapter<WorkBlockHive> {
  @override
  final int typeId = 2;

  @override
  WorkBlockHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkBlockHive(
      workBlockHiveMap: (fields[0] as Map)?.cast<String, WorkHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkBlockHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.workBlockHiveMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkBlockHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
