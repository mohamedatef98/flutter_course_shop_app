import 'package:flutter/material.dart';
import 'package:project_4/provided-models/auth.dart';
import 'package:project_4/provided-models/cart.dart';
import 'package:project_4/provided-models/favorite_products.dart';
import 'package:project_4/provided-models/orders.dart';
import 'package:project_4/provided-models/products-list.dart';
import 'package:project_4/screens/auth-screen.dart';
import 'package:project_4/screens/cart.dart';
import 'package:project_4/screens/orders.dart';
import 'package:project_4/screens/products.dart';
import 'package:project_4/screens/user_products.dart';
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
        ChangeNotifierProvider<AuthModel>(
          create: (_) => AuthModel()
        ),
        ChangeNotifierProxyProvider<AuthModel, ProductsListModel>(
          create: (_) => ProductsListModel(null),
          update: (_, authModel, __) => ProductsListModel(authModel),
        ),
        ChangeNotifierProvider<CartModel>(
          create: (_) => CartModel(),
        ),
        ChangeNotifierProxyProvider<AuthModel, OrdersModel>(
          create: (_) => OrdersModel(null),
          update: (_, authModel, __) => OrdersModel(authModel),
        ),
        ChangeNotifierProxyProvider<AuthModel, FavoriteProductsModel>(
          create: (_) => FavoriteProductsModel(null),
          update: (_, authModel, __) => FavoriteProductsModel(authModel),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange
          ),
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            color: Colors.purple
          )
        ),
        home: Consumer<AuthModel>(
          builder: (_, authModel, __) => authModel.isAuthenticated() ? const ProductsScreen() : const AuthScreen(),
        ),
        routes: {
          AuthScreen.routeName: (context) => const AuthScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
        },
      ),
    );
  }
}
