import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_4/provided-models/products-list.dart';
import 'package:project_4/screens/product_form.dart';
import 'package:project_4/widgets/app_drawer.dart';
import 'package:project_4/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsModel = Provider.of<ProductsListModel>(context);
    final products = productsModel.allItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductFormScreen(
                  onProductSave: (productFields) {
                    return productsModel.addProductFromProductForm(productFields);
                  },
                )
              ));
            },
            icon: const Icon(Icons.add)
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: productsModel.loadProducts,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) => UserProductItem(
              product: products[index]
            )
          ),
      ),
      )
    );
  }
}