import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

class HiveService {
  final usersBox = Hive.box('users');

  // REGISTER
  void register(UserModel user) {
    usersBox.put(user.username, user.toMap());
  }

  // LOGIN
  UserModel? login(String username, String password) {
    final data = usersBox.get(username);
    if (data == null) return null;

    final user = UserModel.fromMap(data);

    if (user.password == password) {
      return user;
    }
    return null;
  }
}
