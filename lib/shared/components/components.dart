// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigatTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    )
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route){
      return false;
    }
);

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = const Color.fromARGB(255, 64, 101, 131),
  double radius = 0.0,
  required String name,
  required Function function,
}) =>
    Container(
      width: width,
      // color: backgroundColor,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required String text,
  required TextInputType textInputType,
  required var prefixicon,
  var suffixicon = null,
  var isSuffixicon = false,
  bool isPassword = false,
  Function? suffixPressed,
  Function? validate,
  Function? ontap,
  var onSubmit,
  var onchange,
  var contexti = null,
}) =>
    TextFormField(
        onFieldSubmitted: onSubmit,
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          // hintText: "Email Address",

          labelText: text,
          border: const OutlineInputBorder(),
          prefixIcon: prefixicon,
          suffixIcon: suffixicon == null
              ? null
              : IconButton(
                  icon: Icon(suffixicon),
                  onPressed: () {
                    suffixPressed!();
                  },
                ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field Is Empty';
          } else {
            if (text == 'Email Address') {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value);
              if (!emailValid) {
                return '$value not valid email';
              }
            }
          }
          return null;
        },
        onChanged: onchange,
        onTap: ontap == null
            ? null
            : () {
                ontap();
              });

Future<bool?> boast(
{
  required message,
  gravity = ToastGravity.CENTER,
  textColor = Colors.white,
  bgColor = Colors.red,
  toastLength = Toast.LENGTH_SHORT,
  fontSize = 16.0,
  timeInSecForIosWeb = 1,

}
    ){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: fontSize
  );
}