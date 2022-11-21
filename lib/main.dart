import 'package:flutter/material.dart';
import 'package:project_4/provided-models/products-list.dart';
import 'package:project_4/screens/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductsListModel>.value(
      value: ProductsListModel(),
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            secondary: Colors.deepOrange
          ),
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            color: Colors.purple
          )
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
