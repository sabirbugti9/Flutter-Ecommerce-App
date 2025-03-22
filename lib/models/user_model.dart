class UserModel {
  final String token;
  final String name;
  final String role;
  final String email;
  final String avatar;

  UserModel({
    required this.token,
    required this.name,
    required this.role,
    required this.email,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['access_token'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
