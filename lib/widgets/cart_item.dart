import 'package:flutter/material.dart';
import 'package:project_4/models/cart_item.dart' as cart_item_model;

class CartItem extends StatelessWidget {
  final cart_item_model.CartItem cartItem;
  final void Function(cart_item_model.CartItem) onCartItemDecrease;
  final void Function(cart_item_model.CartItem) onCartItemIncrease;
  final void Function(cart_item_model.CartItem) onCartItemRemove;
  const CartItem({
    super.key,
    required this.cartItem,
    required this.onCartItemDecrease,
    required this.onCartItemIncrease,
    required this.onCartItemRemove
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4
      ),
      child: Dismissible(
        key: ValueKey(cartItem.id),
        background: Container(),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          padding: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onCartItemRemove(cartItem),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text('\$${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Column(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: FittedBox(
                    child: Container(
                      child: IconButton(
                        onPressed: () => onCartItemIncrease(cartItem),
                        icon: const Icon(Icons.add)
                      ),
                    ),
                  )
                ),
                Text('x${cartItem.quantity}'),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: FittedBox(
                    child: Container(
                      child: IconButton(
                        onPressed: () => onCartItemDecrease(cartItem),
                        icon: const Icon(Icons.remove)
                      ),
                    ),
                  )
                ),         
              ],
            ),
          ),
        ),
      )
    );
  }
}