import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _itens = {};

  Map<String, CartItem> get itens {
    return {..._itens};
  }

  void removeItem(String id) {
    _itens.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String prductid) {
    if (!_itens.containsKey(prductid)) return;

    if (_itens[prductid]?.quantity == 1) {
      _itens.remove(prductid);
    } else {
      _itens.update(
          prductid,
          (existentItem) => CartItem(
                id: existentItem.id,
                productId: existentItem.productId,
                name: existentItem.name,
                quantity: existentItem.quantity - 1,
                price: existentItem.price,
              ));
    }

    notifyListeners();
  }

  void clear() {
    _itens = {};
    notifyListeners();
  }

  int get itensCount {
    return _itens.length;
  }

  double get totalAmount {
    double total = 0;
    _itens.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_itens.containsKey(product.id)) {
      _itens.update(
          product.id,
          (existentItem) => CartItem(
                id: existentItem.id,
                productId: existentItem.productId,
                name: existentItem.name,
                quantity: existentItem.quantity + 1,
                price: existentItem.price,
              ));
    } else {
      _itens.putIfAbsent(
        product.id,
        () {
          return CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.name,
            quantity: 1,
            price: product.price,
          );
        },
      );
    }
    notifyListeners();
  }
}
