import 'package:equatable/equatable.dart';

class TherapistEntity extends Equatable {
  final String id;
  final String fullName;
  final double rating;
  final String phone;
  final String photo;
  final String category;
  final String license;
  final double price;
  final String description;
  final bool verified;

  const TherapistEntity({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.rating,
    required this.photo,
    required this.category,
    required this.license,
    required this.price,
    required this.description,
    required this.verified,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'age': rating,
      'gender': photo,
      'category': category,
      'license': license,
      'price': price,
      'description': description,
      'verified': verified,
    };
  }

  static TherapistEntity fromDocument(Map<String, dynamic> doc) {
    return TherapistEntity(
      id: doc['id'] as String,
      fullName: doc['fullName'] as String,
      phone: doc['phone'] as String,
      rating: doc['rating'] as double,
      photo: doc['photo'] as String,
      category: doc['category'] as String,
      license: doc['license'] as String,
      price: doc['price'] as double,
      description: doc['description'] as String,
      verified: doc['verified'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        fullName,
        rating,
        photo,
        category,
        license,
        price,
        description,
        verified
      ];
}
