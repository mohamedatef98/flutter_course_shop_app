import 'package:flutter/material.dart';
import 'package:project_4/provided-models/cart.dart';
import 'package:project_4/provided-models/orders.dart';
import 'package:project_4/widgets/app_drawer.dart';
import 'package:project_4/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final ordersModel = Provider.of<OrdersModel>(context, listen: false);
    final products = cartModel.products;
    final disableOrderNow = (cartModel.products.isEmpty || isLoading == true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      drawer: const AppDrawer(),
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
                      '\$${cartModel.totalAmount.toStringAsFixed(2)}'
                    ),
                  ),
                  isLoading ? const CircularProgressIndicator() : TextButton(
                    onPressed: disableOrderNow ? null : () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await ordersModel.addOrder(cartModel.products, cartModel.totalAmount).then((value) => cartModel.clear());
                      }
                      finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    ),
                    child: const Text('ORDER NOW!'),
                    
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
                onCartItemRemove: (cartItem) => cartModel.removeItem(cartItem.id),
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