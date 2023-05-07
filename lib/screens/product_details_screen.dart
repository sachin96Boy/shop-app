import 'package:flutter/material.dart';


class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('my details screen'),
      ),
      body: const Center(child: Text('body of the product')),
    );
  }
}
