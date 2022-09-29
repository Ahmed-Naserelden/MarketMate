// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopping/modules/login/login_screen.dart';
import 'package:shopping/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopping/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool to = true, _isObscure = true, _isObscureRe = true;
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var fName = TextEditingController();
  var lName = TextEditingController();
  var password = TextEditingController();
  var rePassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 55, 89, 117),
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                
                
                defaultTextFormField(
                  text: 'First Name',
                  textInputType: TextInputType.text,
                  prefixicon: const Icon(Icons.person),
                  controller: fName,
                ),
                SizedBox(height: 15.0,),
                defaultTextFormField(
                  text: 'Last Name',
                  textInputType: TextInputType.text,
                  prefixicon: const Icon(Icons.person),
                  controller: lName,
                ),
                
                const SizedBox(
                  height: 35,
                ),
                defaultTextFormField(
                  text: 'Email Address',
                  textInputType: TextInputType.emailAddress,
                  prefixicon: const Icon(Icons.email),
                  controller: email,
                ),
                const SizedBox(
                  height: 35,
                ),
                
                
                defaultTextFormField(
                  text: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  prefixicon: const Icon(Icons.lock),
                  controller: password,
                  isPassword: _isObscure,
                  suffixicon:
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                  suffixPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                
                defaultTextFormField(
                  text: 'Repeat Password',
                  textInputType: TextInputType.visiblePassword,
                  prefixicon: const Icon(Icons.lock),
                  controller: rePassword,
                  isPassword: _isObscureRe,
                  suffixicon:
                      _isObscureRe ? Icons.visibility_off : Icons.visibility,
                  suffixPressed: () {
                    setState(() {
                      _isObscureRe = !_isObscureRe;
                    });
                  },
                ),
                
                
                
                const SizedBox(
                  height: 35,
                ),
                defaultButton(
                    name: "Register",
                    radius: 10.0,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        navigatTo(context, OnBoardingScreen());
                      }
                    }),
                
                
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I have an account ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigateAndFinish(context, LoginScreen());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
