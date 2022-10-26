class User {
  late String name;
  late String address;
  late String mobile;
  late String email;
  late String password;
  late String confirmPassword;
  late String gender;

  User({
    required this.address,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.name,
    required this.password,
    required this.confirmPassword,
  });
}
