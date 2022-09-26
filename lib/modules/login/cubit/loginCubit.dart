// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/modules/login/cubit/states.dart';
import 'package:shopping/shared/network/endpoints.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(InitialState());

  bool to = true, isObscure = true;
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  late ShopLoginModel shopLoginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  // void userLogin({required String email, required String password}){
  //     DioHelper.postDate(url: LOGIN, data: {
  //       'email' : email,
  //       'password': password,
  //     }).then((value){
  //       print('From LoginCubit postData() -> ${value.data}');
  //       emit(SuccessLogin());
  //     }).catchError((err){
  //       print(err.toString());
  //       emit(FailLogin());
  //     });
  // }

  void showPassword(){
    isObscure = !isObscure;
    emit(ShowPasswordState());
  }


  void userLogin({
    required email,
    required password,
  }){
    emit(ShopLoginLoadingState());

     DioHelper.postDate(
         url: LOGIN,
         data: {
           'email': email,
           'password': password,
         }).then((value){
           print(value.data['status']);
           shopLoginModel = ShopLoginModel.fromJson(value.data);
           // print(shopLoginModel.status);
           // print(shopLoginModel.message);
           // print(shopLoginModel.data);

           emit(SuccessLogin(shopLoginModel));
         }).catchError((error){
           print(error.toString());
           emit(FailureLogin());
         });
  }




}