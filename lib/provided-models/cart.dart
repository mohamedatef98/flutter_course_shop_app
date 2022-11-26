import 'package:flutter/cupertino.dart';
import 'package:project_4/models/cart_item.dart';
import 'package:project_4/provided-models/product.dart';

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  get items => {..._cartItems};

  get itemCount => _cartItems.values.fold(0, (previousValue, cartItem) => previousValue + cartItem.quantity);

  List<CartItem> get products => [..._cartItems.values];

  double get totalAmount => _cartItems.values.fold(0.0, (previousValue, cartItem) => previousValue + (cartItem.quantity * cartItem.price));

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
  void increaseItem(String productId) {
    final oldCartItem = _cartItems[productId];
    assert(oldCartItem != null);
    _cartItems[productId] = CartItem(
      id: oldCartItem!.id,
      title: oldCartItem.title,
      quantity: oldCartItem.quantity + 1,
      price: oldCartItem.price
    );
    notifyListeners();
  }
  void decreaseItem(String productId) {
    final oldCartItem = _cartItems[productId];
    assert(oldCartItem != null);
    if(oldCartItem!.quantity == 1) {
      _cartItems.remove(productId);
    }
    else {
      _cartItems[productId] = CartItem(
        id: oldCartItem.id,
        title: oldCartItem.title,
        quantity: oldCartItem.quantity - 1,
        price: oldCartItem.price
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }
}
