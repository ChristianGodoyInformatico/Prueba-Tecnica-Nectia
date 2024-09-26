class VehicleModel {
  final String id;
  final String brand;
  final String model;
  final int year;
  final double price;
  final String type;

  VehicleModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.type,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      price: (json['price'] as num).toDouble(),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'price': price,
      'type': type,
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      "brand": brand,
      "model": model,
      "year": year,
      "price": price,
      "type": type,
    };
  }
}
