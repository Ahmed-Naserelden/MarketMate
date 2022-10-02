// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/models/home_model.dart';
import 'package:shopping/modules/categories/categories_screen.dart';
import 'package:shopping/modules/favorites/favorites_screen.dart';
import 'package:shopping/modules/login/cubit/loginCubit.dart';
import 'package:shopping/modules/products/product_screen.dart';
import 'package:shopping/modules/settings/settings_screen.dart';
import 'package:shopping/shared/components/constants.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

import '../../../shared/network/endpoints.dart';

class ShopCubit extends Cubit<ShopStatus>{
  ShopCubit() : super(ShopInitialStatus());

  static ShopCubit get(context) => BlocProvider.of(context);

  late bool isDark, onBoarding;
  late String token;
  int currentIndex = 0;

  List<Widget> bottomScreens = const [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItems =  const [
    BottomNavigationBarItem(
        icon:  Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon:  Icon(Icons.apps),
        label: 'Categories'
    ),
    BottomNavigationBarItem(
        icon:  Icon(Icons.favorite),
        label: 'Favorites'
    ),
    BottomNavigationBarItem(
        icon:  Icon(Icons.settings),
        label: 'Settings'
    ),
  ];

  void start(){

    onBoarding = CachHelper.getData(key: 'onBoarding')??false;
    token = CachHelper.getData(key: 'token');
    // print(onBoarding);

  }

  void changeBottom(int index){
    currentIndex = index;
    emit(ChangeBottomNavStatus());
  }

  HomeDataModel? homeDataModel;
  void getHomeData(){
    emit(ShopLoadingDataStatus());
    DioHelper.getDate(url: HOME, token: token).then((value) {
      homeDataModel = HomeDataModel.fromJson(value.data);
      print(homeDataModel!.status);
      print(homeDataModel!.status);
      print(homeDataModel!.status);
      // print(homeDataModel.toString());
      emit(ShopLoadingDataSuccessStatus());
    }).catchError((error){
      print(error.toString());
      emit(ShopLoadingDataErrorStatus());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    emit(ShopLoadingCategoriesStatus());
    DioHelper.getDate(url: CATEGORIES,).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        print('categoriesModel!.status => ${categoriesModel!.status}');
        emit(ShopSuccessCategoriesStatus());
    }).catchError((error){
        print(error.toString());
        emit(ShopErrorCategoriesStatus());
    });

  }

}