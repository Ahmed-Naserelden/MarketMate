// ignore_for_file: avoid_print, unnecessary_string_escapes, dead_code, prefer_const_constructors, missing_required_param

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/shop_layout.dart';
import 'package:shopping/modules/login/cubit/loginCubit.dart';
import 'package:shopping/modules/login/cubit/states.dart';
import 'package:shopping/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopping/modules/register/register.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/components/constants.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is SuccessLogin){
            if(state.shopLoginModel.status == true)
              {
                token = state.shopLoginModel.data!.token;
                boast(message:state.shopLoginModel.message, bgColor: Colors.green, gravity: ToastGravity.BOTTOM);
                print("Login Token ${state.shopLoginModel.data!.token}");
                ShopCubit.get(context).afterLogin();
                CachHelper.saveData(key: 'token', value: state.shopLoginModel.data!.token).then((value){
                  navigateAndFinish(context, ShopLayout());
                }).catchError((err){
                  print(err.toString());
                });
              }else{
                print(state.shopLoginModel.message);
                boast(message:state.shopLoginModel.message, gravity: ToastGravity.BOTTOM);
              }
          }
        },

        builder: (context, state) {
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
                          color: Colors.deepOrange,
                          fontFamily: 'serif',
                        ),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                      defaultTextFormField(
                        text: 'Email Address',
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email),
                        controller: cubit.email,
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
                        prefixIcon: Icon(Icons.lock),
                        controller: cubit.password,
                        isPassword: cubit.isObscure,
                        isSuffixIcon:
                        cubit.isObscure ? Icons.visibility_off : Icons.visibility,
                        suffixPressed: () {
                          cubit.showPassword();
                        },
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
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        fallback: (context) => Center(child: CircularProgressIndicator(),),
                        builder: (context) => defaultButton(
                            name: "Login",
                            radius: 10.0,
                            function: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: cubit.email.text,
                                    password: cubit.password.text
                                );
                              }
                            }),
                      ),
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
                              navigateAndFinish(context, RegisterScreen());
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
