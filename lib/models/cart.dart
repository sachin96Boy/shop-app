import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items;

  Cart(this._items);

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    // add to cart, if already
    //add only increse or decrease quantity
    if (_items.containsKey(productId)) {
      // cage quantity
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              quantity: value.quantity + 1,
              title: value.title));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            price: price,
            quantity: 1,
            title: title),
      );
    }
  }
}
