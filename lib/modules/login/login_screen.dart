// ignore_for_file: avoid_print, unnecessary_string_escapes, dead_code, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/loginCubit.dart';
import 'package:shopping/modules/login/cubit/states.dart';
import 'package:shopping/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopping/modules/register/register.dart';
import 'package:shopping/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(

        listener: (context, status) {},
        builder: (context, status) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
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
                        text: 'Email Address',
                        textInputType: TextInputType.emailAddress,
                        prefixicon: Icon(Icons.email),
                        controller: cubit.email,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      defaultTextFormField(
                        text: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        prefixicon: Icon(Icons.lock),
                        controller: cubit.password,
                        isPassword: cubit.isObscure,
                        suffixicon:
                        cubit.isObscure ? Icons.visibility_off : Icons.visibility,
                        suffixPressed: () {
                          cubit.showPassword();
                        },
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      defaultButton(
                          name: "Login",
                          radius: 10.0,
                          function: () {
                            if (cubit.formKey.currentState!.validate()) {
                              print(cubit.email.text);
                              print(cubit.password.text);
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
        }),
    );
  }
}
