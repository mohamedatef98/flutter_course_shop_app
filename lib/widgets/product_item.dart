import 'package:flutter/material.dart';
import 'package:project_4/provided-models/cart.dart';
import 'package:project_4/provided-models/product.dart';
import 'package:project_4/screens/product_details.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key
  });

  void handleProductTap(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ProductDetailsScreen(product: product)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:  Consumer<Product>(
        builder: (context, product, child) {
          return GridTile(
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
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: product.toggleFavorite,
              ),
              title: Text(
                '\$${product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  cartModel.addItem(product);
                },
              ),
            ),
            child: GestureDetector(
              onTap: () => handleProductTap(context, product),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            )
          );
        },
      )
    );
  }
}