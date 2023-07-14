import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15.0),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium
                              ?.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    child: const Text(
                      'Order Now',
                    ),
                    onPressed: () {},
                  ),
                ],
              )),
        )
      ]),
    );
  }
}
