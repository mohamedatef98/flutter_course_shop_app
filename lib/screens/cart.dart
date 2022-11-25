import 'package:flutter/material.dart';
import 'package:project_4/provided-models/cart.dart';
import 'package:project_4/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final products = cartModel.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartModel.totalAmount}'
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    ),
                    child: const Text('ORDER NOW!')
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => CartItem(
                cartItem: products[index],
                onCartItemDecrease: (cartItem) => cartModel.decreaseItem(cartItem.id),
                onCartItemIncrease: (cartItem) => cartModel.increaseItem(cartItem.id),
              ),
            ),
          )
        ],
      ),
    );
  }
}