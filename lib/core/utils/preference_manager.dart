import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static final box = GetStorage();

  static void saveUserRole(String role) {
    box.write('role', role);
  }

  static String? getUserRole() {
    return box.read('role');
  }

  static void removeUserRole() {
    box.remove('role');
  }

  static saveToken(token) => box.write('token', token);

  static saveUsername(username) => box.write('username', username);

  static getUsername(username) => box.read('username');

  static getToken() => box.read('token');
}
