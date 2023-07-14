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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(color: Colors.grey, fontSize: 20.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
