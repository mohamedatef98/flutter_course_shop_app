import 'package:flutter/material.dart';
import 'package:project_4/widgets/products-grid.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: const ProductGrid(),
    );
  }
}