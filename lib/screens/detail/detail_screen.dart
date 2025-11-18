import 'package:flutter/material.dart';
import '/models/product_model.dart';
import '/services/session_service.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;

  DetailScreen({required this.product});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final session = SessionService();
  List<int> cartIds = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  void loadCart() async {
    cartIds = await session.getCart();
    setState(() {});
  }

  void toggleCart() async {
    if (cartIds.contains(widget.product.id)) {
      cartIds.remove(widget.product.id);
    } else {
      cartIds.add(widget.product.id);
    }

    await session.saveCart(cartIds);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            Center(
              child: Image.network(
                p.image,
                height: 200,
              ),
            ),
            SizedBox(height: 20),

            
            Text(
              p.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            
            Text(
              "\$${p.price}",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 10),

            
            Text(
              "Category: ${p.category}",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),

            
            Text(
              p.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),

            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  cartIds.contains(p.id)
                      ? "Remove from Cart"
                      : "Add to Cart",
                ),
                onPressed: toggleCart,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
