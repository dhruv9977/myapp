// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CatalogModel {
  static List<Product>? products;
}

class Product {
  final String colorName;
  final String colorCode;

  const Product({
    required this.colorName,
    required this.colorCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'colorName': colorName,
      'colorCode': colorCode,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      colorName: map['colorName'] as String,
      colorCode: map['colorCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Product copyWith({
    String? colorName,
    String? colorCode,
  }) {
    return Product(
      colorName: colorName ?? this.colorName,
      colorCode: colorCode ?? this.colorCode,
    );
  }

  @override
  String toString() => 'Product(colorName: $colorName, colorCode: $colorCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.colorName == colorName &&
        other.colorCode == colorCode;
  }

  @override
  int get hashCode => colorName.hashCode ^ colorCode.hashCode;
}
