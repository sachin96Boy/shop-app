import 'package:flutter/material.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.amount,
    required this.products,
    required this.dateTime,
    required this.id,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders;

  Orders(this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProduccts, double total) {
    _orders.insert(
        0,
        OrderItem(
          amount: total,
          products: cartProduccts,
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
        ));
    notifyListeners();
  }
}
