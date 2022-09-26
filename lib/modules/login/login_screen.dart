// ignore_for_file: avoid_print, unnecessary_string_escapes, dead_code, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopping/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopping/modules/register/register.dart';
import 'package:shopping/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool to = true, _isObscure = true;
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 55, 89, 117),
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                defaultTextFormField(
                  text: 'Email Adress',
                  textInputType: TextInputType.emailAddress,
                  prefixicon: Icon(Icons.email),
                  controller: email,
                ),
                const SizedBox(
                  height: 35,
                ),
                defaultTextFormField(
                  text: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  prefixicon: Icon(Icons.lock),
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
                  height: 35,
                ),
                defaultButton(
                    name: "Login",
                    radius: 10.0,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(email.text);
                        print(password.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnBoardingScreen(),
                            ));
                      }
                    }),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don\'t have an account ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigatTo(context, RegisterScreen());
                      },
                      child: const Text(
                        "Register Now",
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
