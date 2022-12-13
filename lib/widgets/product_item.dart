import 'package:flutter/material.dart';
import 'package:project_4/provided-models/cart.dart';
import 'package:project_4/provided-models/favorite_products.dart';
import 'package:project_4/provided-models/product.dart';
import 'package:project_4/screens/product_details.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  static const waitingImage = 'assets/images/product-placeholder.png';
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
    final favoriteProductsModel = Provider.of<FavoriteProductsModel>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:  Consumer<Product>(
        builder: (context, product, child) {
          final isFavoriteProduct = favoriteProductsModel.isFavoriteProduct(product.id);

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
                icon: Icon(isFavoriteProduct ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  (isFavoriteProduct ?
                    favoriteProductsModel.removeFavoriteProduct(product.id) :
                    favoriteProductsModel.addFavoriteProduct(product.id)
                  ).catchError((_) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error while setting favorite'))));
                },
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
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Item Added'),
                    action: SnackBarAction(
                      label: 'Undo?',
                      onPressed: () => cartModel.decreaseItem(product.id),
                    ),
                  ));
                },
              ),
            ),
            child: GestureDetector(
              onTap: () => handleProductTap(context, product),
              child: FadeInImage(
                placeholder: const AssetImage(waitingImage),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
              
            )
          );
        },
      )
    );
  }
}