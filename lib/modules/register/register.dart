// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
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
  var phone = TextEditingController();
  var password = TextEditingController();
  var rePassword = TextEditingController();
  @override
  Widget build(BuildContext context) {



    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
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
                          color: Colors.deepOrange,
                          fontFamily: 'serif',
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),


                      defaultTextFormField(
                        text: 'Name',
                        textInputType: TextInputType.text,
                        prefixIcon: const Icon(Icons.person),
                        controller: fName,
                        validate: (text){
                          if(text.isEmpty){

                            return 'field must not empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.0,),
                      defaultTextFormField(
                        text: 'Phone',
                        textInputType: TextInputType.text,
                        prefixIcon: const Icon(Icons.phone),
                        controller: phone,
                        validate: (text){
                          if(text.isEmpty){

                            return 'field must not empty';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 35,
                      ),
                      defaultTextFormField(
                        text: 'Email Address',
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                        controller: email,
                        validate: (text){
                          if(text.isEmpty){

                            return 'field must not empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      defaultTextFormField(
                        text: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(Icons.lock),
                        controller: password,
                        isPassword: _isObscure,
                        suffixIcon:
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
                        prefixIcon: const Icon(Icons.lock),
                        controller: rePassword,
                        isPassword: _isObscureRe,
                        validate: (text){
                          if(text != password.text){

                            return 'Passwords must match';
                          }
                          return null;
                        },
                        suffixIcon:
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
                             ShopCubit.get(context).register(fName.text, phone.text, email.text, password.text, '');
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
        },
        listener: (context, state){}
    );

  }
}


/*



*/