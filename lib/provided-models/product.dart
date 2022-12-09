import 'package:flutter/cupertino.dart';
import 'package:project_4/helpers/env.dart';
import '../helpers/http.dart' as http;

class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false
  });

  Future<void> toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
    return http.patch(
      getProductUri(id),
      {
        'isFavorite': isFavorite
      }
    ).catchError((error) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw error;
    });
  }
}
