import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
import '../widgets/drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const SideDrawer(),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (context, index) => OrderItemCard(
                order: ordersData.orders[index],
              )),
    );
  }
}
