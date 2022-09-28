// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

class ShopCubit extends Cubit<ShopStatus>{
  ShopCubit() : super(ShopInitialStatus());

  static ShopCubit get(context) => BlocProvider.of(context);

  late bool isDark, onBoarding;
  late String token;
  int currentIndex = 0;

  void start(){

    onBoarding = CachHelper.getData(key: 'onBoarding')??false;
    token = CachHelper.getData(key: 'token');
    // print(onBoarding);

  }

  void changeIndex(int index){
    currentIndex = index;
    emit(state);
  }




}