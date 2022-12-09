const apiUrl = 'flutter-shop-app-da674-default-rtdb.europe-west1.firebasedatabase.app';

final productsUri = Uri.https(apiUrl, 'products.json');

Uri getProductUri(String productId) {
  return Uri.https(apiUrl, 'products/$productId.json');
}

final ordersUri = Uri.https(apiUrl, 'orders.json');

Uri getOrderUri(String orderId) {
  return Uri.https(apiUrl, 'orders/$orderId.json');
}
