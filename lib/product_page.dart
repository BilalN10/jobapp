import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, this.productId});

  final int? productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('product id : $productId'),
      ),
    );
  }
}
