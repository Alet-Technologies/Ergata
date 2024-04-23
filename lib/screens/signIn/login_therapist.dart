// ignore_for_file: prefer_const_constructors

import 'package:ergata/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/screens/otp/therapist/otp_screen_therapist.dart';
import 'package:ergata/screens/signIn/loginpage.dart';
import 'package:ergata/service/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginTherapistScreen extends StatefulWidget {
  const LoginTherapistScreen({super.key});

  @override
  State<LoginTherapistScreen> createState() => _LoginTherapistScreenState();
}

class _LoginTherapistScreenState extends State<LoginTherapistScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  bool isPhoneValidated = false;
  String countryCode = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/ergata.png",
                    width: MediaQuery.of(context).size.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    "Only for therapists",
                    style: TextStyle(
                        color: ColorsManager.coralRed,
                        fontStyle: FontStyle.italic,
                        fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: IntlPhoneField(
                  dropdownIcon: Icon(
                    Icons.arrow_drop_down,
                    color: ColorsManager.secondaryColor,
                  ),
                  dropdownTextStyle: TextStyle(color: ColorsManager.darkBlue),
                  keyboardType: TextInputType.phone,
                  initialCountryCode: 'ET',
                  disableLengthCheck: true,
                  cursorColor: ColorsManager.secondaryColor,
                  onChanged: (value) {
                    if (value.number.isNotEmpty) {
                      setState(() {
                        countryCode = value.countryCode;
                        print(countryCode);
                      });
                      removeError(error: "Phone number not entered");
                    }
                  },
                  validator: (value) {
                    if (value!.number == "") {
                      setState(() {
                        isPhoneValidated = false;
                      });
                    } else {
                      setState(() {
                        isPhoneValidated = true;
                      });
                    }
                  },
                  controller: _phoneController,
                  style: TextStyle(color: ColorsManager.primaryColor),
                  decoration: InputDecoration(
                      focusColor: ColorsManager.primaryColor,
                      fillColor: Colors.grey[850],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isPhoneValidated
                                  ? ColorsManager.secondaryColor
                                  : ColorsManager.coralRed)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isPhoneValidated
                                  ? ColorsManager.secondaryColor
                                  : ColorsManager.coralRed)),
                      hintText: '000-000-0000',
                      hintStyle: TextStyle(
                          color: ColorsManager.secondaryColor,
                          fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primaryColor),
                  onPressed: () {
                    if (isPhoneValidated) {
                      _formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          SendOTPTherapist(countryCode + _phoneController.text,
                              () {
                        Navigator.pop(context);
                      }, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OtpScreenTherapist(
                                phone: countryCode + _phoneController.text)));
                      }));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 62),
                      child: Text('Want to find a therapist? '),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            'Login here.',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
