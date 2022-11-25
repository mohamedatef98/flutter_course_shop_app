import 'package:flutter/cupertino.dart';
import 'package:project_4/models/cart_item.dart';
import 'package:project_4/provided-models/product.dart';

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  get items => {..._cartItems};

  get itemCount => _cartItems.values.fold(0, (previousValue, cartItem) => previousValue + cartItem.quantity);

  void addItem(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(product.id, (existingCartItem) => CartItem(
        id: existingCartItem.id,
        title: existingCartItem.title,
        quantity: existingCartItem.quantity + 1,
        price: existingCartItem.price
      ));
    }
    else {
      _cartItems[product.id] = CartItem(
        id: product.id,
        title: product.title,
        quantity: 1,
        price: product.price
      );
    }
    notifyListeners();
  }
}