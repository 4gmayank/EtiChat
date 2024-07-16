class UserEntity {
  final String email;
  final String country;
  final String displayName;
  final String password;
  final String confirmPassword;
  final String mobile;
  final String? token;

  UserEntity({
    required this.email,
    required this.country,
    required this.displayName,
    required this.password,
    required this.confirmPassword,
    required this.mobile,
    required this.token,
  });

  // Factory method to create a UserRegistration object from a JSON map
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      email: json['email'],
      country: json['country'],
      displayName: json['displayName'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      mobile: json['mobile'],
      token: json['token'],
    );
  }

  // Method to convert a UserRegistration object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'country': country,
      'displayName': displayName,
      'password': password,
      'confirmPassword': confirmPassword,
      'mobile': mobile,
    };
  }

  @override
  String toString() {
    return 'UserRegistration{email: $email, country: $country, displayName: $displayName, password: $password, confirmPassword: $confirmPassword, mobile: $mobile}';
  }
}
