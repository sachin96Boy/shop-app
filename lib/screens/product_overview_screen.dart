import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/drawer.dart';

import '../widgets/products_grid.dart';

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
          Consumer<Cart>(
            builder: (_, cartData, ch) => BadgeCount(
                value: cartData.itemCount.toString(),
                color: Colors.orange,
                child: ch),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              alignment: Alignment.center,
            ),
          )
        ],
      ),
      drawer: const SideDrawer(),
      body: ProductsGrid(showFavourites: _showOnlyFavourites),
    );
  }
}
