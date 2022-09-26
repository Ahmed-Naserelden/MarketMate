import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/states.dart';
import 'package:shopping/shared/network/endpoints.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(InitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}){
      DioHelper.postDate(url: LOGIN, data: {
        'email' : email,
        'password': password,
      }).then((value){
        print('From LoginCubit postData() -> ${value.data}');
        emit(SuccessLogin());
      }).catchError((err){
        print(err.toString());
        emit(FailLogin());
      });
  }







}