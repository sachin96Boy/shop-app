import 'package:flutter/material.dart';

import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { favourites, all }

class ProductOveviewScreen extends StatefulWidget {
  const ProductOveviewScreen({super.key});

  @override
  State<ProductOveviewScreen> createState() => _ProductOveviewScreenState();
}

class _ProductOveviewScreenState extends State<ProductOveviewScreen> {
  bool _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop App'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              // add logic here
              setState(() {
                if (value == FilterOptions.favourites) {
                  // reduce displayed items
                  // products.showFavouritesOnly();
                  _showOnlyFavourites = true;
                } else {
                  // show all items
                  // products.showAll();
                  _showOnlyFavourites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilterOptions.favourites,
                child: Text('only Favourites'),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show all'),
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(showFavourites: _showOnlyFavourites),
    );
  }
}
