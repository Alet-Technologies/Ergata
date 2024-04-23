// ignore_for_file: library_private_types_in_public_api

import 'package:ergata/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ergata/constants/colors.dart';
import 'package:ergata/screens/home/homepage_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OtpFormPatient extends StatefulWidget {
  final String phone;

  const OtpFormPatient({
    super.key,
    required this.phone,
  });

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpFormPatient> {
  final TextEditingController pin1Controller = TextEditingController();
  final TextEditingController pin2Controller = TextEditingController();
  final TextEditingController pin3Controller = TextEditingController();
  final TextEditingController pin4Controller = TextEditingController();
  final TextEditingController pin5Controller = TextEditingController();
  final TextEditingController pin6Controller = TextEditingController();

  String otpCode = "";

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  Widget buttonChild = const Text("Continue");

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ColorsManager.secondaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessPatient) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePagePatient(
                        patient: state.patient,
                      )));
        } else if (state is AuthenticationFailed) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 220,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.red,
                                size: 80,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(child: Text("Something went wrong!")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
        if (state is AuthenticationLoading) {
          setState(() {
            buttonChild = LoadingAnimationWidget.prograssiveDots(
              color: Colors.white,
              size: 20,
            );
          });
        }
      },
      child: Form(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40,
                  child: TextFormField(
                    controller: pin1Controller,
                    autofocus: true,
                    obscureText: true,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      enabledBorder: outlineInputBorder(),
                    ),
                    onChanged: (value) {
                      nextField(value, pin2FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                    controller: pin2Controller,
                    focusNode: pin2FocusNode,
                    obscureText: true,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      enabledBorder: outlineInputBorder(),
                    ),
                    onChanged: (value) => nextField(value, pin3FocusNode),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                    controller: pin3Controller,
                    focusNode: pin3FocusNode,
                    obscureText: true,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      enabledBorder: outlineInputBorder(),
                    ),
                    onChanged: (value) => nextField(value, pin4FocusNode),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                      controller: pin4Controller,
                      focusNode: pin4FocusNode,
                      obscureText: true,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                      ),
                      onChanged: (value) => nextField(value, pin5FocusNode)),
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                      controller: pin5Controller,
                      focusNode: pin5FocusNode,
                      obscureText: true,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                      ),
                      onChanged: (value) => nextField(value, pin6FocusNode)),
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                    controller: pin6Controller,
                    focusNode: pin6FocusNode,
                    obscureText: true,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      enabledBorder: outlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin6FocusNode!.unfocus();
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryColor,
                ),
                onPressed: () async {
                  buttonChild = const CircularProgressIndicator(
                    color: Colors.white,
                  );
                  otpCode = pin1Controller.text.toString() +
                      pin2Controller.text.toString() +
                      pin3Controller.text.toString() +
                      pin4Controller.text.toString() +
                      pin5Controller.text.toString() +
                      pin6Controller.text.toString();
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(SignInPatient(otpCode, widget.phone));
                },
                child: buttonChild),
          ],
        ),
      ),
    );
  }
}
