import 'package:flutter/material.dart';
import 'package:project_4/models/filters.dart';
import 'package:project_4/provided-models/favorite_products.dart';
import 'package:project_4/provided-models/product.dart';
import 'package:project_4/provided-models/products-list.dart';
import 'package:project_4/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final Filters filter;
  const ProductGrid({
    super.key,
    required this.filter
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductsListModel, FavoriteProductsModel>(
      builder: (context, productsListModel, favoriteProductsModel, child) {
        final products = filter == Filters.favorites ?
          favoriteProductsModel.filterFavoriteProducts(productsListModel.allItems) :
          productsListModel.allItems;

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Provider.value(
              value: products[index],
              child: const ProductItem(),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.25,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
          ),
        );
      }
    );
  }
}