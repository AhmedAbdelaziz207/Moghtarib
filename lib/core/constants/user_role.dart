sealed class UserRole {
  static const student = "طالب";
  static const broker = "سمسار";
  static const technical = "صنايعي";

 static String translate(role) {
    switch (role) {
      case student:
        return "student";
      case broker:
        return "broker";
      case technical:
        return "technical";
      default:
        return "";
    }
  }
}