import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  
  Future saveLogin(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  
  Future<String?> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  
  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  
  Future saveCart(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cart', ids.map((e) => e.toString()).toList());
  }

  Future<List<int>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('cart') ?? [];
    return list.map((e) => int.parse(e)).toList();
  }
}
