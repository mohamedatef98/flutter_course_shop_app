class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  const CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> getCartItemMap() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price
    };
  }

  static CartItem createCartItemFromMap(Map<String, dynamic> cartItemMap) {
    return CartItem(
      id: cartItemMap['id'],
      title: cartItemMap['title'],
      quantity: cartItemMap['quantity'],
      price: cartItemMap['price']
    );
  }
}
