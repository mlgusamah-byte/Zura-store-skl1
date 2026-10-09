import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Menyimpan username saat login
  static Future<void> login(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);
    await prefs.setBool('isLogin', true);
  }

  // Mengambil username yang sudah disimpan
  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('username') ?? 'Pengguna';
  }

  // Mengecek status login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isLogin') ?? false;
  }

  // Menghapus session saat logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('username');
    await prefs.remove('isLogin');
  }
}
