import 'package:flutter/material.dart';
import 'package:project_4/data/products.dart';
import 'package:project_4/models/product.dart';
import 'package:project_4/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> products = PRODUCTS;
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.25,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
      ),
    );
  }
}