import 'package:flutter/foundation.dart';
import 'package:project_4/helpers/env.dart';
import 'package:project_4/models/cart_item.dart';
import '../helpers/http.dart' as http;

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
  final List<OrderItem> _orders = [];
  bool _isLoading = false;


  get isLoading => _isLoading;
  get orders => [..._orders];

    void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _clearLoading() {
    _isLoading = false;
    notifyListeners();
  }


  OrdersModel() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    _setLoading();
    try {
      final response = await http.get(ordersUri);
      final ordersMap = response;
      _orders.clear();
      for(final orderEntry in ordersMap.entries) {
        final orderId = orderEntry.key;
        final orderFields = orderEntry.value;
        assert(orderFields['amount'] != null);
        assert(orderFields['products'] != null);
        assert(orderFields['time'] != null);

        _orders.add(OrderItem(
          id: orderId,
          amount: orderFields['amount'],
          products: (orderFields['products'] as List<dynamic>)
            .map((cartItemEntry) => CartItem.createCartItemFromMap(cartItemEntry as Map<String, dynamic>)).toList(),
          time: DateTime.parse(orderFields['time'])
        ));
      }
      notifyListeners();
    }
    finally {
      _clearLoading();
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) {
    final now = DateTime.now();
    final orderFields = {
      'amount': total,
      'products': cartProducts.map((cartItem) => cartItem.getCartItemMap(),).toList(),
      'time': now.toIso8601String()
    };
    return http.post(
      ordersUri,
      orderFields
    ).then((response) {
      _orders.insert(0, OrderItem(
        id: response['name'],
        amount: total,
        products: cartProducts,
        time: now
      ));
      notifyListeners();
    });
  }
}
