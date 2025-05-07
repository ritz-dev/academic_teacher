import 'package:academic_teacher/bloc/settings/settings_event.dart';
import 'package:academic_teacher/bloc/settings/settings_state.dart';
import 'package:academic_teacher/data/model/settings_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
