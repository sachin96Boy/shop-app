import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return Consumer<Product>(
      builder: (context, product, _) => ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black.withOpacity(0.6),
              leading: IconButton(
                icon: Icon(!product.isFavourite
                    ? Icons.favorite_border
                    : Icons.favorite),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  product.toggleFavourite();
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_bag),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  // add item to cart
                  cart.addItem(product.id, product.price, product.title);
                  // show snackbar component
                  final snackBar = SnackBar(
                    content: const Text('Item added to cart successfully'),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              )),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: {'id': product.id}),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
