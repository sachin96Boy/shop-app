import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final prodId = args['id'] as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('my details screen'),
      ),
      body: Center(child: Text(prodId)),
    );
  }
}
