import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavourites;
  const ProductsGrid({super.key, required this.showFavourites});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        showFavourites ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              // using changenotifierprovider.value because
              // there is no use in passing the context
              value: products[index],
              child: const ProductItem(),
            ),
        itemCount: products.length);
  }
}
