import 'package:flutter/material.dart';
import 'package:project_4/models/filters.dart';
import 'package:project_4/provided-models/cart.dart';
import 'package:project_4/screens/cart.dart';
import 'package:project_4/widgets/badge.dart';
import 'package:project_4/widgets/products-grid.dart';
import 'package:provider/provider.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  Filters filter = Filters.showAll;

  void handlePopUpMenuSelected (Filters filterValue) {
    setState(() {
      filter = filterValue;
    });
  }

  void handleCartIconOnPress(BuildContext context) {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: handlePopUpMenuSelected,
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: Filters.favorites,
                child: Text('Only Favorites'),
              ),
              PopupMenuItem(
                value: Filters.showAll,
                child: Text('Show All'),
              )
            ],
          ),
          Consumer<CartModel>(
            builder: (context, cartModel, child) => Badge(
              value: cartModel.itemCount.toString(),
              child: child!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => handleCartIconOnPress(context),
            ),
          )
        ],
      ),
      body: ProductGrid(
        filter: filter,
      ),
    );
  }
}