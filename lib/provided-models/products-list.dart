import 'package:flutter/foundation.dart';
import 'package:project_4/helpers/env.dart';
import 'package:project_4/provided-models/auth.dart';
import 'package:project_4/provided-models/product.dart';
import '../helpers/http.dart' as http;

class ProductsListModel extends ChangeNotifier {
  final List<Product> _items = [];

  final List<String> _userProductIds = [];

  bool _isLoadingAllProducts = false;

  bool _isLoadingUserProducts = false;

  AuthModel? _authModel;

  ProductsListModel(AuthModel? authModel): super() {
    _authModel = authModel;
    if ((authModel != null) && (authModel.isAuthenticated() == true)) {
      loadAllProducts();
      loadUserProducts();
    }
  }

  List<Product> get allItems => [..._items];

  List<Product> get userItems => [..._userProductIds.map((userProductId) => _items.firstWhere((product) => product.id == userProductId))];

  get isLoadingAllProducts => _isLoadingAllProducts;

  get isLoadingUserProducts => _isLoadingUserProducts;
  
  void _setLoadingAllProducts() {
    _isLoadingAllProducts = true;
    notifyListeners();
  }

  void _clearLoadingAllProducts() {
    _isLoadingAllProducts = false;
    notifyListeners();
  }

  void _setLoadingUserProducts() {
    _isLoadingUserProducts = true;
    notifyListeners();
  }

  void _clearLoadingUserProducts() {
    _isLoadingUserProducts = false;
    notifyListeners();
  }

  Future<void> loadAllProducts() async {
    _setLoadingAllProducts();
    try {
      final response = await http.get(allProductsUri(_authModel!.getToken()));
      final productsMap = response;
      _items.clear();
      for(final productEntry in productsMap.entries) {
        final productId = productEntry.key;
        final productFields = productEntry.value;
        assert(productFields['title'] != null);
        assert(productFields['description'] != null);
        assert(productFields['price'] != null);
        assert(productFields['imageUrl'] != null);

        _items.add(Product(
          id: productId,
          title: productFields['title']!,
          description: productFields['description']!,
          price: double.parse(productFields['price']!),
          imageUrl: productFields['imageUrl']!,
        ));
      }
      notifyListeners();
    }
    finally {
      _clearLoadingAllProducts();
    }
  }

  Future<void> loadUserProducts() async {
    _setLoadingUserProducts();
    try {
      final response = await http.get(userProductsUri(_authModel!.getToken(), _authModel!.getUserId()));
      final productsMap = response;
      _userProductIds.clear();
      for(final productEntry in productsMap.entries) {
        final productId = productEntry.key;

        _userProductIds.add(productId);
      }
      notifyListeners();
    }
    finally {
      _clearLoadingUserProducts();
    }
  }

  Future<void> addProductFromProductForm(Map<String, String> productFields) {
    return http.post(
      getAddproductUri(_authModel!.getToken()),
      {
        ...productFields,
        'creatorUserId': _authModel!.getUserId()
      },
    ).then((response) {
      final String? id = (response)['name'] as String?;
      assert(id != null);
      assert(productFields['title'] != null);
      assert(productFields['description'] != null);
      assert(productFields['price'] != null);
      assert(productFields['imageUrl'] != null);

      _items.add(Product(
        id: id!,
        title: productFields['title']!,
        description: productFields['description']!,
        price: double.parse(productFields['price']!),
        imageUrl: productFields['imageUrl']!,
      ));
      _userProductIds.add(id);
      notifyListeners();
    });
  }

  Future<void> editProductFromProductForm(String productId, Map<String, String> productFields) async {
    assert(productFields['title'] != null);
    assert(productFields['description'] != null);
    assert(productFields['price'] != null);
    assert(productFields['imageUrl'] != null);

    return http.patch(
      getProductUri(productId, _authModel!.getToken()),
      productFields,
    ).then((response) {
      final newProductFields = response;

      final productIndex = _items.indexWhere((product) => product.id == productId);
      assert(productIndex != -1);

      _items[productIndex] = Product(
        id: DateTime.now().toString(),
        title: newProductFields['title']!,
        description: newProductFields['description']!,
        price: double.parse(newProductFields['price']!),
        imageUrl: newProductFields['imageUrl']!,
      );
      notifyListeners();
    });
  }
  
  Future<void> removeProduct(String productId) {
    return http.delete(
      getProductUri(productId, _authModel!.getToken()),
    ).then((value) {
      final productIndex = _items.indexWhere((product) => product.id == productId);
      assert(productIndex != -1);

      final oldProduct = _items[productIndex];
      _items.remove(oldProduct);
      notifyListeners();
    });
  }
}
