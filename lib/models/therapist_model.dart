import 'package:equatable/equatable.dart';
// import 'package:shop_app/entities/user_entity.dart';

class MyTherapist extends Equatable {
  final String id;
  final String phone;
  final String fullname;
  final String photo;
  final double rating;
  final String category;
  final String licence;
  final double price;
  final String description;
  final bool verified;

  const MyTherapist({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.photo,
    required this.category,
    required this.description,
    required this.licence,
    required this.price,
    required this.rating,
    required this.verified,
  });

  toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'phone': phone,
      'photo': photo,
      'category': category,
      'description': description,
      'licence': licence,
      'price': price,
      'rating': rating,
      'verified': verified,
    };
  }

  static final empty = MyTherapist(
    id: "",
    fullname: "",
    phone: "",
    photo: "",
    category: "",
    description: "",
    licence: "",
    price: 0,
    rating: 0,
    verified: false,
  );

  MyTherapist copyWith({
    String? id,
    String? phone,
    String? fullname,
    String? photo,
    String? category,
    String? licence,
    double? price,
    double? rating,
    String? description,
    bool? verified,
  }) {
    return MyTherapist(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      category: category ?? this.category,
      description: description ?? this.description,
      licence: licence ?? this.licence,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      verified: verified ?? this.verified,
    );
  }

  TherapistEntity toEntity() {
    return TherapistEntity(
      id: id,
      phone: phone,
      fullname: fullname,
      photo: photo,
      category: category,
      description: description,
      licence: licence,
      price: price,
      rating: rating,
      verified: verified,
    );
  }

  static MyTherapist fromEntity(TherapistEntity entity) {
    return MyTherapist(
      id: entity.id,
      fullname: entity.fullname,
      phone: entity.phone,
      photo: entity.photo,
      category: entity.category,
      description: entity.description,
      licence: entity.licence,
      price: entity.price,
      rating: entity.rating,
      verified: entity.verified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        fullname,
        photo,
        category,
        description,
        licence,
        price,
        rating,
        verified,
      ];
}