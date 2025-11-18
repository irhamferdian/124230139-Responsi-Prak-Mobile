import 'package:flutter/material.dart';
import '/models/product_model.dart';
import '/services/api_service.dart';
import '/services/session_service.dart';
import '../detail/detail_screen.dart';
import '/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final api = ApiService();
  final session = SessionService();

  List<int> cartIds = [];
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  void loadCart() async {
    cartIds = await session.getCart();
    products = api.fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Semua produk
          final allProducts = snapshot.data ?? [];

          // Filter berdasarkan ID di cart
          final cartProducts = allProducts
              .where((p) => cartIds.contains(p.id))
              .toList();

          if (cartProducts.isEmpty) {
            return Center(
              child: Text("Keranjang kosong"),
            );
          }

          return ListView.builder(
            itemCount: cartProducts.length,
            itemBuilder: (context, index) {
              final item = cartProducts[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(product: item),
                    ),
                  );
                },
                child: CartItem(product: item),
              );
            },
          );
        },
      ),
    );
  }
}
