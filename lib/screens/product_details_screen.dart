import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final prodId = args['id'] as String;
    final loadedProduct =
        Provider.of<ProductsProvider>(context, listen: false).findById(prodId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Center(child: Text(loadedProduct.description)),
    );
  }
}
