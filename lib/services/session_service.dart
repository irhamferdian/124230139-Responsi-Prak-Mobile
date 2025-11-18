import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // simpan username untuk login session
  Future saveLogin(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  // ambil username (cek session)
  Future<String?> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // logout
  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  // CART → simpan list ID produk
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
