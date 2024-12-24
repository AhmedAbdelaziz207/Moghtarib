class UserModel {
  final String? firstName; // Nullable, maxLength: 20
  final String? lastName; // Nullable, maxLength: 20
  final String userName; // Required, minLength: 1, maxLength: 60
  final String email; // Required, minLength: 1, maxLength: 100, email format
  final String nationalId; // Required, minLength: 14, maxLength: 14
  final String phoneNumber; // Required, minLength: 1
  final String whatsappNumber; // Required, minLength: 1
  final String? websiteURL; // Nullable
  final String password; // Required, minLength: 1
  final String role; // Required, minLength: 1
  final int? departmentId; // Nullable

  UserModel({
    this.firstName,
    this.lastName,
    required this.userName,
    required this.email,
    required this.nationalId,
    required this.phoneNumber,
    required this.whatsappNumber,
    this.websiteURL,
    required this.password,
    required this.role,
    this.departmentId,
  });

  /// Converts JSON map to UserModel instance
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String,
      email: json['email'] as String,
      nationalId: json['nationalId'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String,
      websiteURL: json['websiteURL'] as String?,
      password: json['password'] as String,
      role: json['role'] as String,
      departmentId: json['departmentId'] as int?,
    );
  }

  /// Converts UserModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'nationalId': nationalId,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'websiteURL': websiteURL,
      'password': password,
      'role': role,
      'departmentId': departmentId,
    };
  }
}
