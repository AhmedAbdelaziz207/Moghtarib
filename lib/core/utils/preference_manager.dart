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
}
