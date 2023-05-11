import 'package:flutter/material.dart';

import 'package:shop_app/widgets/products_grid.dart';

class ProductOveviewScreen extends StatelessWidget {
  const ProductOveviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Shop App')),
      body: const ProductsGrid(),
    );
  }
}
