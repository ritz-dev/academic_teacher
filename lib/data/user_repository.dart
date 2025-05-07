import 'package:academic_teacher/data/api_provider.dart';

class UserRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<String> login(String email, String password) {
    return _apiProvider.login(email, password);
  }

  Future<bool> me() {
    return _apiProvider.me();
  }

  Future<void> removeToken() {
    return _apiProvider.deleteAuthToken();
  }

  Future<String?> getToken() async {
    return await _apiProvider.getAuthToken();
  }
}
