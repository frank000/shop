import 'package:flutter/widgets.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList extends ChangeNotifier {
  final List<Product> _itens = dummyProducts;
  bool _showFavoriteOnly = false;

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  int get itensCount {
    return _itens.length;
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  List<Product> get itens {
    if (_showFavoriteOnly) {
      return _itens.where((prod) => prod.isFavorite).toList();
    }
    return [..._itens];
  }

  void addProduct(Product product) {
    _itens.add(product);
    notifyListeners();
  }
}
