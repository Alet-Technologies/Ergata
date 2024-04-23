import 'package:ergata/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDivider {
  static Widget buildDivider() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 2.h,
        decoration: ShapeDecoration(
          color: ColorsManager.gray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
