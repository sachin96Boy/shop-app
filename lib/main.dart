import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop Application',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.orange,
        ),
      ),
      home: ProductOveviewScreen(),
    );
  }
}
