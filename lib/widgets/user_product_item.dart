import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_4/provided-models/product.dart';
import 'package:project_4/provided-models/products-list.dart';
import 'package:project_4/screens/product_form.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  const UserProductItem({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(product.title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductFormScreen(
                        onProductSave: (productFields) {
                          Provider.of<ProductsListModel>(context, listen: false).editProductFromProductForm(product.id, productFields);
                        },
                        product: product,
                      )
                    ));
                  },
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('No')
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Yes')
                            )
                          ],
                        );
                      }
                    ).then((value) {
                      assert(value != null);
                      if(value == true) {
                        Provider.of<ProductsListModel>(context, listen: false).removeProduct(product.id);
                      }
                    });
                  },
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                )
              ],
            ),
          )
        ),
        const Divider()
      ],
    );
  }
}