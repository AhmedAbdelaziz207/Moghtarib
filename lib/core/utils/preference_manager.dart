import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static final box = GetStorage();

  static void saveUserRole(String role) {
    box.write('role', role);
  }

  static String? getUserId() {
    return box.read('userId');
  }

  static String? getUserRole() {
    return box.read('role');
  }

  static void removeUserRole() {
    box.remove('role');
  }
  static void removeAll() {
    box.erase();
  }


  static saveToken(token) => box.write('token', token);

  static saveUsername(username) => box.write('username', username);

  static saveUserid(username) => box.write('userId', username);

  static getUsername() => box.read('username');

  static getToken() => box.read('token');
}
