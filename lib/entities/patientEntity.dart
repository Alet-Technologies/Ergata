import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final String id;
  final String phone;
  final String age;
  final String gender;

  const PatientEntity(
      {required this.id,
      required this.phone,
      required this.age,
      required this.gender});

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'phone': phone,
      'age': age,
      'gender': gender,
    };
  }

  static PatientEntity fromDocument(Map<String, dynamic> doc) {
    return PatientEntity(
      id: doc['id'] as String,
      phone: doc['phone'] as String,
      age: doc['age'] as String,
      gender: doc['gender'] as String,
    );
  }

  @override
  List<Object?> get props => [id, phone, age, gender];
}
