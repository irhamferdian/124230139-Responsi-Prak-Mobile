import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const baseUrl = "https://fakestoreapi.com";

  Future<List<ProductModel>> fetchProducts() async {
    final res = await http.get(Uri.parse("$baseUrl/products"));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.map((item) => ProductModel.fromJson(item)).toList();
    }
    return [];
  }
}
