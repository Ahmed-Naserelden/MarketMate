import 'package:flutter/material.dart';

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
          style: TextStyle(
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
  var onchange,
  var contexti = null,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          // hintText: "Email Adress",

          labelText: text,
          border: OutlineInputBorder(),
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
            return 'Field Is Emapty';
          } else {
            if (text == 'Email Adress') {
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

