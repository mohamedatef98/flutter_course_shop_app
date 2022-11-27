import 'package:flutter/material.dart';
import 'package:project_4/provided-models/cart.dart';
import 'package:project_4/provided-models/orders.dart';
import 'package:project_4/provided-models/products-list.dart';
import 'package:project_4/screens/cart.dart';
import 'package:project_4/screens/orders.dart';
import 'package:project_4/screens/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsListModel>(
          create: (_) => ProductsListModel(),
        ),
        ChangeNotifierProvider<CartModel>(
          create: (_) => CartModel(),
        ),
        ChangeNotifierProvider<OrdersModel>(
          create: (_) => OrdersModel()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        routes: {
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen()
        },
      ),
    );
  }
}
