import 'package:equatable/equatable.dart';
import 'package:ergata/entities/patient_entity.dart';

class MyPatient extends Equatable {
  final String id;
  final String phone;
  final String age;
  final bool isDiagnosed;
  final String diagnosedWith;

  const MyPatient({
    required this.id,
    required this.phone,
    required this.age,
    required this.isDiagnosed,
    required this.diagnosedWith,


  });

  toJson() {
    return {'id': id, 'phone': phone, 'age': age, 'isDiagnosed': isDiagnosed, 'diagnosedWith': diagnosedWith};
  }

  static final empty = MyPatient(id: "", phone: "", age: "",  isDiagnosed:false,diagnosedWith: "");

  MyPatient copyWith({
    String? id,
    String? phone,
    String? age,
    String? photo,
    bool ? isDiagnosed,
    String? diagnosedWith,

  }) {
    return MyPatient(
        id: id ?? this.id,
        age: age ?? this.age,
        phone: phone ?? this.phone,
        isDiagnosed: isDiagnosed?? this.isDiagnosed,
        diagnosedWith: diagnosedWith??this.diagnosedWith
        );
  }

  PatientEntity toEntity() {
    return PatientEntity(id: id, phone: phone,  age: age, isDiagnosed: isDiagnosed,diagnosedWith: diagnosedWith);
  }

  static MyPatient fromEntity(PatientEntity entity) {
    return MyPatient(
      id: entity.id,
      age: entity.age,
      phone: entity.phone,
      isDiagnosed: entity.isDiagnosed,
      diagnosedWith: entity.diagnosedWith,
    );
  }

  @override
  List<Object?> get props => [id, phone, age, isDiagnosed,diagnosedWith ];
}
