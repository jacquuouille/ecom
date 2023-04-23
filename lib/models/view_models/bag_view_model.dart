import 'package:flutter/material.dart';
import '../product.dart';

class BagViewModel extends ChangeNotifier {
  final List<Product> productsBag;
  BagViewModel() : productsBag = [];

//1. let's create functions to...
  void addProduct(Product product) {
    productsBag.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    productsBag.remove(product); 
    notifyListeners();
  }

  void clearBag() {
    productsBag.clear(); 
    notifyListeners();
  }

//2. let's create getter
  int get totalProducts => productsBag.length; 

  double get totalPrice => productsBag.fold(0, (total, product) { // fold reduces a collection to a single value by iteratively combining each element of the collection with an existing value. basically, we can use that to sum our collection
    return total + product.price;
  });

  bool get isBagEmpry => productsBag.isEmpty;

//3. let's define it to our providers.dart;

}
