import 'package:flutter/foundation.dart';
import 'package:project_4/models/cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime time;

  const OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.time
  });
}

class OrdersModel extends ChangeNotifier {
  List<OrderItem> _orders = [];

  get orders => [..._orders];

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(0, OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      products: cartProducts,
      time: DateTime.now()
    ));
    notifyListeners();
  }
}
