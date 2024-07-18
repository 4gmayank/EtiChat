class UserEntity {
  final String email;
  final String country;
  final String name;
  final String password;
  final String mobile;
  final String? token;
  final bool session;

  UserEntity({
    required this.email,
    required this.country,
    required this.name,
    required this.password,
    required this.mobile,
    required this.token,
    this.session = false,
  });

  // Factory method to create a UserRegistration object from a JSON map
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      email: json['email'],
      country: json['country'],
      name: json['name'],
      password: json['password'],
      mobile: json['mobile'],
      token: json['token'],
    );
  }

  // Method to convert a UserRegistration object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'country': country,
      'displayName': name,
      'password': password,
      'mobile': mobile,
    };
  }
}
