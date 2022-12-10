const apiUrl = 'flutter-shop-app-da674-default-rtdb.europe-west1.firebasedatabase.app';

Uri allProductsUri(String token) {
  return Uri.parse('${Uri.https(apiUrl, 'products.json').toString()}?auth=$token');
}

Uri userProductsUri(String token, String userId) {
  return Uri.parse('${Uri.https(apiUrl, 'products.json').toString()}?auth=$token&orderBy="creatorUserId"&equalTo="$userId"');
}

Uri getAddproductUri(String token) {
  return Uri.parse("${Uri.https(apiUrl, 'products.json').toString()}?auth=$token");
}

const apiKey = 'AIzaSyCUDTWqq0v-Npu2HLRPebRS8eM6YA9Ywr0';

Uri getProductUri(String productId, String token) {
  return Uri.parse("${Uri.https(apiUrl, 'products/$productId.json').toString()}?auth=$token");
}

Uri userOrdersUri(String token, String userId) {
  return Uri.parse('${Uri.https(apiUrl, 'orders.json').toString()}?auth=$token&orderBy="creatorUserId"&equalTo="$userId"');
}

Uri addOrderUri(String token) {
  return Uri.parse('${Uri.https(apiUrl, 'orders.json').toString()}?auth=$token');
}

Uri getFavouriteProductsUri(String token, String userId) {
  return Uri.parse("${Uri.https(apiUrl, 'usersSettings/$userId/favoriteProducts.json').toString()}?auth=$token");
}

Uri getRemoveFavouriteProductsUri(String token, String userId, String favoriteProductFirebaseKey) {
  return Uri.parse("${Uri.https(apiUrl, 'usersSettings/$userId/favoriteProducts/$favoriteProductFirebaseKey.json').toString()}?auth=$token");
}
