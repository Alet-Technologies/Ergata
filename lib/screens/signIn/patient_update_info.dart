// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

// import 'package:buyme/repository/auth.dart';
// import 'package:buyme/screens/complete_profile/update_extra_info.dart';
import 'package:ergata/entities/patientEntity.dart';
import 'package:flutter/material.dart';
// import 'package:buyme/models/user_model.dart';
import '../../models/user_mode.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

class UpdateInfo extends StatefulWidget {
  const UpdateInfo({
    Key? key,
  }) : super(key: key);

  // final PatientEntity user;

  @override
  _UpdateInfoState createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  // final AuthRepository authRepository = AuthRepository();

  final TextEditingController _nameController = TextEditingController();

  String diagnosed = '';
  String gender = '';
  DateTime? selectedDOB;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buttonChild = Text(
    "Update info",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
  );

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300)),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade300),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
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
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade400),
          ),
          SizedBox(
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
    // _nameController.text = widget.user.name;
    gender = widget.user.gender != "" || widget.user.gender != " "
        ? widget.user.gender!
        : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey.shade900,
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
                // _buildFormField(
                //   label: 'Name',
                //   field: TextFormField(
                //     controller: _nameController,
                //     style: TextStyle(color: Colors.white),
                //     decoration: _inputDecoration(hintText: 'Enter your name'),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter your name';
                //       }
                //       return null;
                //     },
                //     onChanged: (value) {
                //       setState(() {
                //         name = value;
                //       });
                //     },
                //   ),
                // ),
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
                    dropdownColor: Colors.grey[850],
                    value:
                        //  widget.user.gender != "" ? widget.user.gender :
                        'male',
                    items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: Text(
                                gender,
                                style: TextStyle(color: Colors.white),
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
                _buildFormField(
                  label: 'What are you diagnosed with',
                  field: TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: _inputDecoration(
                        hintText: 'eg. Depression,Stress,Bipolar Disorder'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        diagnosed = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String errorMessage = "";
                    if (_formKey.currentState!.validate()) {
                      // setState(() {
                      //   buttonChild = LoadingAnimationWidget.dotsTriangle(
                      //       color: Colors.white, size: 20);
                      // });
                      try {
                        String age = _calculateAge(selectedDOB!).toString();
                        // await authRepository.updateName(
                        //     _nameController.text, widget.user.id);
                        // await authRepository.updateAge(age, widget.user.id);
                        // await authRepository.updateGender(
                        //     gender, widget.user.id);
                      } catch (e) {
                        setState(() {
                          errorMessage = e.toString();
                        });
                      } finally {
                        // if (errorMessage == "") {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               UpdateExtraInfo(user: widget.user)));
                        // }
                      }

                      setState(() {
                        buttonChild = Text(
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
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.pink,
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
