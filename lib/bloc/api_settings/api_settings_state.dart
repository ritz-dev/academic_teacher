part of 'api_settings_bloc.dart';

sealed class ApiSettingsState extends Equatable {
  const ApiSettingsState();
  
  @override
  List<Object> get props => [];
}

final class ApiSettingsInitial extends ApiSettingsState {}

final class ApiSettingsLoading extends ApiSettingsState {}

final class ApiSettingsSuccess extends ApiSettingsState {
  final User user;

  ApiSettingsSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class ApiSettingsError extends ApiSettingsState {
  final String error;
  const ApiSettingsError(this.error);
}
