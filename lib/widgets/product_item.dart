import 'package:flutter/material.dart';
import 'package:project_4/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:  GridTile(
        header: Container(
          color: const Color.fromARGB(206, 0, 0, 0),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: const Color.fromARGB(206, 0, 0, 0),
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
          title: Text(
            '\$${product.price.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
        ),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      )
    );
  }
}