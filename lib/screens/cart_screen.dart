import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/widgets/cart_item.dart';

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
                  const Spacer(),
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
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => CartItemViewer(
                id: cart.items.values.toList()[index].id,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                title: cart.items.values.toList()[index].title),
            itemCount: cart.itemCount,
          ),
        )
      ]),
    );
  }
}
