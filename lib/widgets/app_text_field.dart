import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final bool readOnly;
  final bool maxLines;
  const AppTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.icon,
      this.isObscure = false,
      this.readOnly = false,
      this.maxLines = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 2),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        maxLines: maxLines ? 3 : 1,
        readOnly: readOnly,
        obscureText: isObscure,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15)),
        ),
      ),
    );
  }
}
