import 'package:ergata/constants/colors.dart';
import 'package:ergata/models/therapist_model.dart';
import 'package:ergata/repository/authentication.dart';
import 'package:flutter/material.dart';

class CompleteProfileTherapist extends StatefulWidget {
  final MyTherapist user;

  const CompleteProfileTherapist({super.key, required this.user});

  @override
  State<CompleteProfileTherapist> createState() =>
      _CompleteProfileTherapistState();
}

class _CompleteProfileTherapistState extends State<CompleteProfileTherapist> {
  final AuthRepository authRepository = AuthRepository();
  String bio = '';
  List<String> interests = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buttonChild = const Text(
    "Update info",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
  );

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bio',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Tell us about yourself',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorsManager.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      bio = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  'Interests',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 10,
                  children: [
                    for (String interest in [
                      'Travel',
                      'Food',
                      'Movies',
                      'Music',
                      'Sports',
                      'Hiking',
                      'Gym',
                      'Yoga',
                      'Fashion',
                      'Games',
                      'Culture',
                      'Love',
                      'Romance'
                    ])
                      ChoiceChip(
                        label: Text(
                          interest,
                        ),
                        selected: interests.contains(interest),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              interests.add(interest);
                            } else {
                              interests.remove(interest);
                            }
                          });
                        },
                        backgroundColor: Colors.green.shade100,
                        selectedColor: ColorsManager.primaryColor,
                        elevation: 3,
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          buttonChild = const Text("...");
                        });

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
                      primary: ColorsManager.primaryColor,
                    ),
                    child: buttonChild,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
