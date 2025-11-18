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

  late Future<List<ProductModel>> productsFuture;
  List<int> cartIds = [];

  @override
  void initState() {
    super.initState();
    productsFuture = loadData();    
  }

  Future<List<ProductModel>> loadData() async {
    cartIds = await session.getCart();     
    return await api.fetchProducts();      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productsFuture,   
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text("Keranjang kosong"));
          }

          final allProducts = snapshot.data!;
          final cartProducts = allProducts
              .where((p) => cartIds.contains(p.id))
              .toList();

          if (cartProducts.isEmpty) {
            return Center(child: Text("Keranjang kosong"));
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
