import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'models/cart.dart';
import 'models/orders.dart';
import 'models/product_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/product_overview_screen.dart';
import 'screens/user_products_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'my-shopnew-app',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, CartItem> items = {};
    final List<OrderItem> orders = [];
    // pass changenotifierprovider.value when the context object is not usefull in the scene
    // here if we pass the builer, it jst don't use the context so we could just
    // pass _ to the context or follow this approach
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(items),
        ),
        ChangeNotifierProvider.value(
          value: Orders(orders),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop Application',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.green,
            secondary: Colors.orange,
          ),
        ),
        home: const ProductOveviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen()
        },
      ),
    );
  }
}
