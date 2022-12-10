import 'package:flutter/cupertino.dart';
import 'package:project_4/helpers/env.dart';
import 'package:project_4/provided-models/auth.dart';
import 'package:project_4/provided-models/product.dart';
import '../helpers/http.dart' as http;

class FavoriteProductsModel extends ChangeNotifier {
  final Map<String, String> _favoriteProducts = {};

  AuthModel? _authModel;

  FavoriteProductsModel(AuthModel? authModel) {
    _authModel = authModel;
    if ((_authModel != null) && (_authModel!.isAuthenticated() == true)) {
      _loadFavoriteProducts();
    }
  }

  Future<void> _loadFavoriteProducts() async {
    final response = await http.get(
      getFavouriteProductsUri(
        _authModel!.getToken(),
        _authModel!.getUserId()
      )
    );

    _favoriteProducts.clear();

    response.forEach((firebaseFavoriteProductKey, productId) {
      _favoriteProducts[productId] = firebaseFavoriteProductKey;
    });
    notifyListeners();
  }

  Future<void> addFavoriteProduct(String productId) async {
    _favoriteProducts[productId] = "PENDING";
    notifyListeners();
    
    try {
      final response = await http.post(
        getFavouriteProductsUri(_authModel!.getToken(), _authModel!.getUserId()),
        productId
      );

      _favoriteProducts[productId] = response[0]["name"];
    }
    catch(error) {
      _favoriteProducts.remove(productId);
      notifyListeners();
      rethrow;
    }

  }

  Future<void> removeFavoriteProduct(String productId) async {
    final firebaseFavoriteProductKey = _favoriteProducts[productId];
    if (firebaseFavoriteProductKey != null) {
      try {
        _favoriteProducts.remove(productId);
        notifyListeners();
        final response = await http.delete(
          getRemoveFavouriteProductsUri(_authModel!.getToken(), _authModel!.getUserId(), firebaseFavoriteProductKey)
        );
      }
      catch(error) {
        _favoriteProducts[productId] = firebaseFavoriteProductKey;
        notifyListeners();
        rethrow;
      }
    }
  }

  bool isFavoriteProduct(String productId) {
    return _favoriteProducts[productId] != null;
  }

  List<Product> filterFavoriteProducts(List<Product> products) {
    return products.where((product) => _favoriteProducts[product.id] != null).toList();
  }
}
