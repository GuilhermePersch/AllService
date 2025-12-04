// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<Service> {
  @override
  final int typeId = 0;

  @override
  Service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Service(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as String,
      fields[4] as String,
      fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.nome_cliente)
      ..writeByte(4)
      ..write(obj.endereco)
      ..writeByte(5)
      ..write(obj.valor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
