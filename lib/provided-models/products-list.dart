import 'package:flutter/foundation.dart';
import 'package:project_4/provided-models/product.dart';

class ProductsListModel extends ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get allItems => [..._items];

  get favoriteItems => [..._items.where((item) => item.isFavorite == true)];

  void addProductFromProductForm(Map<String, String> productFields) {
    assert(productFields['title'] != null);
    assert(productFields['description'] != null);
    assert(productFields['price'] != null);
    assert(productFields['imageUrl'] != null);

    _items.add(Product(
      id: DateTime.now().toString(),
      title: productFields['title']!,
      description: productFields['description']!,
      price: double.parse(productFields['price']!),
      imageUrl: productFields['imageUrl']!
    ));
    notifyListeners();
  }

  void editProductFromProductForm(String productId, Map<String, String> productFields) {
    assert(productFields['title'] != null);
    assert(productFields['description'] != null);
    assert(productFields['price'] != null);
    assert(productFields['imageUrl'] != null);

    final productIndex = _items.indexWhere((product) => product.id == productId);
    assert(productIndex != -1);

    final oldProduct = _items[productIndex];
    oldProduct.dispose();
    _items[productIndex] = Product(
      id: DateTime.now().toString(),
      title: productFields['title']!,
      description: productFields['description']!,
      price: double.parse(productFields['price']!),
      imageUrl: productFields['imageUrl']!,
      isFavorite: oldProduct.isFavorite
    );
    notifyListeners();
  }
  
  void removeProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
