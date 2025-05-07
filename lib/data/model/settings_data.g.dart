
part of 'settings_data.dart'; 

class SettingsItemAdapter extends TypeAdapter<SettingsItem>{
  @override
  SettingsItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int,dynamic>{
      for(int i=0;i<numOfFields;i++) reader.readByte(): reader.read
    };

    return SettingsItem(
      name: fields[0] as String,
      email: fields[1] as String,
      role: fields[2] as String,
      key: '',
    );
  }

  @override

  int get typeId => throw UnimplementedError();

  @override
  void write(BinaryWriter writer, SettingsItem obj) {
    writer 
      ..writeByte(3) 
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

}