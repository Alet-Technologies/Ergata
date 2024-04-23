import 'package:equatable/equatable.dart';

class TherapistEntity extends Equatable {
  final String id;
  final String phone;
  final String fullName;
  final String photo;
  final int rating;
  final String category;
  final String license;
  final int price;
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
      'rating': rating,
      'photo': photo,
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
      phone: doc['phone'] as String,
      fullName: doc['fullName'] as String,
      photo: doc['photo'] as String,
      rating: doc['rating'] as int,
      category: doc['category'] as String,
      license: doc['license'] as String,
      price: doc['price'] as int,
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
