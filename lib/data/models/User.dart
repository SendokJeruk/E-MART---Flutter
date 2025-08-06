class User {
  final String name;
  final String email;
  final String password;
  final String no_telp;
  final String role;
  final String? google_id;
  final String? google_token;
  final String? google_refresh_token;
  final String? accessToken;
  final String? tokenType;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.no_telp,
    required this.role,
    this.google_id,
    this.google_token,
    this.google_refresh_token,
    this.accessToken,
    this.tokenType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'] ?? '',
      no_telp: json['no_telp'] ?? '',
      role: json['role'] ?? '',
      google_id: json['google_id'],
      google_token: json['google_token'],
      google_refresh_token: json['google_refresh_token'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}
