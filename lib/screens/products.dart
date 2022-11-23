import 'package:flutter/material.dart';
import 'package:project_4/models/filters.dart';
import 'package:project_4/widgets/products-grid.dart';


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
          )
        ],
      ),
      body: ProductGrid(
        filter: filter,
      ),
    );
  }
}