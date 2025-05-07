import 'package:academic_teacher/storage/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebAuthStorage extends StorageInterface{

  @override

  Future<void> saveToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token',token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  @override
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}