import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:project_4/helpers/env.dart';
import 'package:project_4/provided-models/product.dart';
import '../helpers/http.dart' as http;

class ProductsListModel extends ChangeNotifier {
  final List<Product> _items = [];

  bool _isLoading = false;

  ProductsListModel(): super() {
    loadProducts();
  }

  List<Product> get allItems => [..._items];

  get favoriteItems => [..._items.where((item) => item.isFavorite == true)];

  get isLoading => _isLoading;
  
  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _clearLoading() {
    _isLoading = false;
    notifyListeners();
  }



  Future<void> loadProducts() async {
    _setLoading();
    try {
      final response = await http.get(productsUri);
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
          imageUrl: productFields['imageUrl']!
        ));
      }
      notifyListeners();
    }
    finally {
      _clearLoading();
    }
  }

  Future<void> addProductFromProductForm(Map<String, String> productFields) {
    return http.post(
      productsUri,
      {
        ...productFields,
        'isFavorite': false
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
        imageUrl: productFields['imageUrl']!
      ));
      notifyListeners();
    });
  }

  Future<void> editProductFromProductForm(String productId, Map<String, String> productFields) async {
    assert(productFields['title'] != null);
    assert(productFields['description'] != null);
    assert(productFields['price'] != null);
    assert(productFields['imageUrl'] != null);

    return http.patch(
      getProductUri(productId),
      productFields,
    ).then((response) {
      final newProductFields = response;

      final productIndex = _items.indexWhere((product) => product.id == productId);
      assert(productIndex != -1);

      final oldProduct = _items[productIndex];
      oldProduct.dispose();
      _items[productIndex] = Product(
        id: DateTime.now().toString(),
        title: newProductFields['title']!,
        description: newProductFields['description']!,
        price: double.parse(newProductFields['price']!),
        imageUrl: newProductFields['imageUrl']!,
        isFavorite: oldProduct.isFavorite
      );
      notifyListeners();
    });
  }
  
  Future<void> removeProduct(String productId) {
    return http.delete(
      getProductUri(productId),
    ).then((value) {
      final productIndex = _items.indexWhere((product) => product.id == productId);
      assert(productIndex != -1);

      final oldProduct = _items[productIndex];
      oldProduct.dispose();
      _items.remove(oldProduct);
      notifyListeners();
    });
  }
}
