import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/orders.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItem order;
  const OrderItemCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: const Icon(Icons.badge_rounded),
        title: Text('\$${order.amount}'),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
