import 'package:academic_teacher/data/model/settings_data.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final List<SettingsItem> settingsItems;
  SettingsLoaded(this.settingsItems);
}

final class SettingsError extends SettingsState{
  final String message;
  SettingsError(this.message);
}

final class SettingsItemSelected extends SettingsState{
  final SettingsItem selectedItem;
  SettingsItemSelected(this.selectedItem);
}

final class SettingsItemChanged extends SettingsState{
  final SettingsItem changedItem;
  SettingsItemChanged(this.changedItem);
}

final class SettingsItemRemoved extends SettingsState{
  final SettingsItem deletedItem;
  SettingsItemRemoved(this.deletedItem);
}
