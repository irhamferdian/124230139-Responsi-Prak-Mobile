class UserModel {
  String username;
  String password;

  UserModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
    };
  }

  factory UserModel.fromMap(Map map) {
    return UserModel(
      username: map["username"],
      password: map["password"],
    );
  }
}
