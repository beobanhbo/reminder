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
      remindAtTime: fields[9] as DateTime,
      deadline: fields[10] as DateTime,
      enableReminder: fields[7] as bool,
      isRepeat: fields[8] as bool,
      week: fields[6] as WeekHive,
      workType: fields[4] as WorkTypeHive,
      workChildMap: (fields[5] as Map)?.cast<String, WorkHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkHive obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.workChildMap)
      ..writeByte(6)
      ..write(obj.week)
      ..writeByte(7)
      ..write(obj.enableReminder)
      ..writeByte(8)
      ..write(obj.isRepeat)
      ..writeByte(9)
      ..write(obj.remindAtTime)
      ..writeByte(10)
      ..write(obj.deadline);
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

class DayOfWeekHiveAdapter extends TypeAdapter<DayOfWeekHive> {
  @override
  final int typeId = 3;

  @override
  DayOfWeekHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayOfWeekHive(
      dayName: fields[0] as String,
      isSelected: fields[1] as bool,
      index: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DayOfWeekHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dayName)
      ..writeByte(1)
      ..write(obj.isSelected)
      ..writeByte(2)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayOfWeekHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeekHiveAdapter extends TypeAdapter<WeekHive> {
  @override
  final int typeId = 4;

  @override
  WeekHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeekHive(
      listDay: (fields[0] as List)?.cast<DayOfWeekHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, WeekHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SavedPendingNotificationIDHiveAdapter
    extends TypeAdapter<SavedPendingNotificationIDHive> {
  @override
  final int typeId = 5;

  @override
  SavedPendingNotificationIDHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPendingNotificationIDHive(
      mapPendingID: (fields[0] as Map)?.map((dynamic k, dynamic v) =>
          MapEntry(k as int, (v as List)?.cast<int>())),
    );
  }

  @override
  void write(BinaryWriter writer, SavedPendingNotificationIDHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.mapPendingID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPendingNotificationIDHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
