import 'package:equatable/equatable.dart';
import 'package:ergata/entities/patiententity.dart';

class MyPatient extends Equatable {
  final String id;
  final String phone;
  final String age;
  final bool isDiagnosed;
  final String gender;
  final String diagnosedWith;

  const MyPatient({
    required this.id,
    required this.phone,
    required this.age,
    required this.gender,
    required this.isDiagnosed,
    required this.diagnosedWith,
  });

  toJson() {
    return {
      'id': id,
      'phone': phone,
      'age': age,
      'gender': gender,
      'isDiagnosed': isDiagnosed,
      'diagnosedWith': diagnosedWith
    };
  }

  static final empty = MyPatient(
      id: "",
      phone: "",
      age: "",
      gender: "",
      isDiagnosed: false,
      diagnosedWith: "");

  MyPatient copyWith({
    String? id,
    String? phone,
    String? age,
    String? photo,
    String? gender,
    bool? isDiagnosed,
    String? diagnosedWith,
  }) {
    return MyPatient(
        id: id ?? this.id,
        age: age ?? this.age,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        isDiagnosed: isDiagnosed ?? this.isDiagnosed,
        diagnosedWith: diagnosedWith ?? this.diagnosedWith);
  }

  PatientEntity toEntity() {
    return PatientEntity(
        id: id,
        age: age,
        phone: phone,
        gender: gender,
        isDiagnosed: isDiagnosed,
        diagnosedWith: diagnosedWith);
  }

  static MyPatient fromEntity(PatientEntity entity) {
    return MyPatient(
      id: entity.id,
      age: entity.age,
      phone: entity.phone,
      gender: entity.gender,
      isDiagnosed: entity.isDiagnosed,
      diagnosedWith: entity.diagnosedWith,
    );
  }

  @override
  List<Object?> get props => [id, phone, age, isDiagnosed, diagnosedWith];
}
