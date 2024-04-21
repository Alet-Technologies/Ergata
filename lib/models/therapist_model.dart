// ignore_for_file: prefer_const_constructors

import 'package:equatable/equatable.dart';
import 'package:ergata/entities/therapistEntity.dart';

class MyTherapist extends Equatable {
  final String id;
  final String phone;
  final String fullName;
  final String photo;
  final double rating;
  final String category;
  final String license;
  final double price;
  final String description;
  final bool verified;

  const MyTherapist({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.photo,
    required this.category,
    required this.description,
    required this.license,
    required this.price,
    required this.rating,
    required this.verified,
  });

  toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'photo': photo,
      'category': category,
      'description': description,
      'license': license,
      'price': price,
      'rating': rating,
      'verified': verified,
    };
  }

  static final empty = MyTherapist(
    id: "",
    fullName: "",
    phone: "",
    photo: "",
    category: "",
    description: "",
    license: "",
    price: 0,
    rating: 0,
    verified: false,
  );

  MyTherapist copyWith({
    String? id,
    String? phone,
    String? fullName,
    String? photo,
    String? category,
    String? license,
    double? price,
    double? rating,
    String? description,
    bool? verified,
  }) {
    return MyTherapist(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      category: category ?? this.category,
      description: description ?? this.description,
      license: license ?? this.license,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      verified: verified ?? this.verified,
    );
  }

  TherapistEntity toEntity() {
    return TherapistEntity(
      id: id,
      phone: phone,
      fullName: fullName,
      photo: photo,
      category: category,
      description: description,
      license: license,
      price: price,
      rating: rating,
      verified: verified,
    );
  }

  static MyTherapist fromEntity(TherapistEntity entity) {
    return MyTherapist(
      id: entity.id,
      fullName: entity.fullName,
      phone: entity.phone,
      photo: entity.photo,
      category: entity.category,
      description: entity.description,
      license: entity.license,
      price: entity.price,
      rating: entity.rating,
      verified: entity.verified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        fullName,
        photo,
        category,
        description,
        license,
        price,
        rating,
        verified,
      ];
}
