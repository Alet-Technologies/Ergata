import 'package:ergata/constants/colors.dart';
import 'package:ergata/screens/otp/therapist/otp_form.dart';
import 'package:flutter/material.dart';

class OtpScreenTherapist extends StatelessWidget {
  static String routeName = "/otp";

  final String phone;

  const OtpScreenTherapist({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  "OTP Verification",
                  style: TextStyle(
                      color: ColorsManager.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  "We sent your code to $phone",
                  style: const TextStyle(color: ColorsManager.secondaryColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "This code will expired in ",
                      style: TextStyle(color: ColorsManager.secondaryColor),
                    ),
                    TweenAnimationBuilder(
                      tween: Tween(begin: 120.0, end: 0.0),
                      duration: const Duration(seconds: 120),
                      builder: (_, dynamic value, child) => Text(
                        "00:${value.toInt()}",
                        style:
                            const TextStyle(color: ColorsManager.primaryColor),
                      ),
                    ),
                  ],
                ),
                OtpFormTherapist(phone: phone),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
