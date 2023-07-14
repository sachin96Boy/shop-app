import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/product_provider.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, CartItem> items = {};
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
              const ProductDetailScreen()
        },
      ),
    );
  }
}
