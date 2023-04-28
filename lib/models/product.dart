class Product {
  final String? id; 
  final String name; 
  final double price; 
  final String description; 
  final String image;
  
  Product({
    final this.id, required this.name, required this.price, required this.description, required this.image
  });

  double get priceWithTax => price * 1.2;

  Map<String, dynamic> toMap(String id) {
    return {
      'id': id, 
      'name': name, 
      'price': price, 
      'description': description, 
      'image': image,
    };
  }

  Product.fromMap(Map<String, dynamic> map):
    id = map['id'] ?? "", 
    name = map['name'] ?? "", 
    price = map['price'] ?? 0.0, 
    description = map['description'] ?? "", 
    image = map['image'] ?? "";

}