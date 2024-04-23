// ignore_for_file: library_private_types_in_public_api

import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/patient_model.dart';
import 'package:ergata/repository/authentication.dart';
import 'package:ergata/screens/home/homepage_patient.dart';
import 'package:flutter/material.dart';

class CompleteProfilePatient extends StatefulWidget {
  const CompleteProfilePatient({super.key, required this.patient});

  final MyPatient patient;

  @override
  _CompleteProfilePatientState createState() => _CompleteProfilePatientState();
}

class _CompleteProfilePatientState extends State<CompleteProfilePatient> {
  final AuthRepository authRepository = AuthRepository();

  final TextEditingController _nameController = TextEditingController();

  String name = '';
  String gender = '';
  DateTime? selectedDOB;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buttonChild = const Text(
    "Complete profile",
    style: TextStyle(
      color: ColorsManager.primaryColor,
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
  );

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorsManager.secondaryColor)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      hintText: hintText,
      hintStyle: const TextStyle(color: ColorsManager.secondaryColor),
      enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorsManager.secondaryColor, width: 0.5)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.primaryColor),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required Widget field,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(136, 42, 59, 43)),
          ),
          const SizedBox(
            height: 5,
          ),
          field,
        ],
      ),
    );
  }

  int _calculateAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey.shade100,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFormField(
                  label: 'Name',
                  field: TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration(hintText: 'Enter your name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
                _buildFormField(
                  label: 'Date of Birth',
                  field: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime(2005),
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2006),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            selectedDOB = selectedDate;
                          });
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        validator: (value) {
                          if (selectedDOB == null) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          }
                        },
                        decoration: _inputDecoration(
                          hintText: selectedDOB == null
                              ? 'Select your date of birth'
                              : '${selectedDOB!.day}/${selectedDOB!.month}/${selectedDOB!.year}',
                        ),
                      ),
                    ),
                  ),
                ),
                _buildFormField(
                  label: 'Gender',
                  field: DropdownButtonFormField<String>(
                    dropdownColor: Colors.grey.shade200,
                    value: "Male",
                    items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: Text(
                                gender,
                                style: const TextStyle(
                                    color: ColorsManager.secondaryColor),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    decoration:
                        _inputDecoration(hintText: 'Select your gender'),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String errorMessage = "";
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        buttonChild = const Text("...");
                      });
                      try {
                        String age = _calculateAge(selectedDOB!).toString();
                      } catch (e) {
                        setState(() {
                          errorMessage = e.toString();
                        });
                      } finally {
                        // if (errorMessage == "") {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => HomePagePatient()));
                        // }
                      }
                      setState(() {
                        buttonChild = const Text(
                          "Update info",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: ColorsManager.primaryColor,
                  ),
                  child: buttonChild,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
