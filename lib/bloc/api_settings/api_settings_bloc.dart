import 'package:academic_teacher/bloc/auth/authentication_state.dart';
import 'package:academic_teacher/data/api_settings_repository.dart';
import 'package:academic_teacher/data/model/api_settings_data.dart';
import 'package:academic_teacher/storage/web_auth_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'api_settings_event.dart';
part 'api_settings_state.dart';

class ApiSettingsBloc extends Bloc<ApiSettingsEvent, ApiSettingsState> {
  ApiSettingsBloc() : super(ApiSettingsInitial()) {
    on<FetchAuthenticatedUser>(_FetchAuthenticatedUser);
  }

  Future<void> _FetchAuthenticatedUser(FetchAuthenticatedUser event,Emitter<ApiSettingsState> emit) async{
    emit(ApiSettingsLoading());

    try {
        final storage = WebAuthStorage();
        final token = await storage.getToken();

         if (token == null) {
          emit(ApiSettingsError("Token is missing or expired. Please log in again."));
          return; // Early return if token is null
        }

        final user = await ApiSettingsRepository().getAuthenticatedUser(token);
        emit(ApiSettingsSuccess(user));
      } catch (e) {
        emit(ApiSettingsError(e.toString()));
      }
  }
}
