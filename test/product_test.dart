
// Multiple tests basics

import 'package:ecom/models/product.dart';
import 'package:flutter_test/flutter_test.dart'; 

void main() {
  test('Product description matched the defined text', () {
    const description = "This is a test description";
    const name = "product";
    final product = Product(
      name: name, 
      description: description, 
      price: 12.99, 
      image: "image"
    ); 
    expect(product.description, description); // takes the actual value and see what you are trying to match
    expect(product.name, name);
  });

  group("Price", () {
    test("Price is correct", () {
      const price = 12.99; 
      final product = Product(
        name: "product name", 
        description: "product descripion", 
        price: price, 
        image: "image"
      );
      expect(product.price, price);
    });

    test("price with tax is correct", () {
      const price = 12.99;
      final product = Product(
        name: "product name", 
        description: "description_name", 
        price: price, 
        image: "image",
      );
      expect(product.priceWithTax, price * 1.2);
    });

  });

}