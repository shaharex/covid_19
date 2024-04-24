class Product {
  final String name;
  final String category;

  Product({
    required this.name,
    required this.category,
  });
}

final List<Product> productList = [
  Product(name: 'apple', category: 'fruits'),
  Product(name: 'carrot', category: 'vegetables'),
  Product(name: 'pineapple', category: 'fruits'),
  Product(name: 'mango', category: 'fruits'),
  Product(name: 'banana', category: 'fruits'),
  Product(name: 'cucumber', category: 'vegetables'),
  Product(name: 'bmw', category: 'car'),
  Product(name: 'mersedes', category: 'car'),
  Product(name: 'tesla', category: 'car'),
];
