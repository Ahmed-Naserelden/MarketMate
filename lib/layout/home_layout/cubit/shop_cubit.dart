// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, list_remove_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/cart_model.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/models/change_favorite_model.dart';
import 'package:shopping/models/favorites_model.dart';
import 'package:shopping/models/home_model.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/modules/cart/CartScreen.dart';
import 'package:shopping/modules/categories/categories_screen.dart';
import 'package:shopping/modules/favorites/favorites_screen.dart';
import 'package:shopping/modules/login/cubit/loginCubit.dart';

import 'package:shopping/modules/products/product_screen.dart';
import 'package:shopping/modules/search/search_screen.dart';
import 'package:shopping/modules/settings/settings_screen.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/components/constants.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';
import 'package:shopping/shared/network/remote/dio_helper.dart';

import '../../../models/profile_model.dart';
import '../../../models/search_result_model.dart';
import '../../../shared/network/endpoints.dart';

class ShopCubit extends Cubit<ShopStatus> {
  ShopCubit() : super(ShopInitialStatus());

  static ShopCubit get(context) => BlocProvider.of(context);

  late bool isDark, onBoarding;
  int currentIndex = 0;
  bool online = false;

  List<Widget> bottomScreens = const [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
    // SearchScreen(),
    // CartScreen(),
  ];

  Widget showScreen(int index){
    return bottomScreens[index];
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.apps),
        label: 'Categories'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];

  void start() {
    onBoarding = CachHelper.getData(key: 'onBoarding') ?? false;
    token = CachHelper.getData(key: 'token');
    print("Token = > ${token}");

    if (token != null && token != '') {
      afterLogin();
    }


    // print(onBoarding);
  }

  void afterLogin() {
    getHomeData();
    getCategoriesData();
    getProfile();
    getCart();
    getFavoriteProduct();
    isConnect();
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavStatus());
  }

  HomeDataModel? homeDataModel;
  Map<int, bool> isInFavorite = {};

  void getHomeData() {
    emit(ShopLoadingDataStatus());
    DioHelper.getDate(url: HOME, token: token).then((value) {
      homeDataModel = HomeDataModel.fromJson(value.data);
      homeDataModel!.data!.products.forEach((element) {
        isInFavorite.addAll({
          element.id!: element.inFavorites!
        });
      });
      print(isInFavorite);
      emit(ShopLoadingDataSuccessStatus());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoadingDataErrorStatus());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesStatus());
    DioHelper.getDate(url: CATEGORIES,).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('categoriesModel!.status => ${categoriesModel!.status}');
      emit(ShopSuccessCategoriesStatus());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStatus());
    });
  }

  FavoriteModel? favoriteProducts;

  void getFavoriteProduct() {
    print("\n\n\n\n");
    DioHelper.getDate(
        url: FAVORITE,
        token: token
    ).then((value) {
      // print(value.data);
      favoriteProducts = FavoriteModel.fromJson(value.data);

      emit(GetFavoriteProductSuccessState());
    }).catchError((err) {
      emit(GetFavoriteProductErrorState());
      print(err.toString());
    });
    print("\n\n\n\n");
    emit(GetFavoriteProductSuccessState());
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavoriteProduct(int productId) {
    isInFavorite[productId] == true
        ? isInFavorite[productId] = false
        : isInFavorite[productId] = true;
    emit(ChangeFavoriteProductState());

    DioHelper.postDate(
      url: FAVORITE,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if (changeFavoriteModel!.status == false) {
        isInFavorite[productId] == true
            ? isInFavorite[productId] = false
            : isInFavorite[productId] = true;
      }

      if (isInFavorite[productId] == true) {
        getFavoriteProduct();
      } else {
        favoriteProducts!.data!.data!.data.removeWhere((element) =>
        element.product!.id == productId);
      }
      emit(ChangeFavoriteProductSuccessState(changeFavoriteModel!));
    }).catchError((err) {
      isInFavorite[productId] == true
          ? isInFavorite[productId] = false
          : isInFavorite[productId] = true;
      print(err.toString());
      emit(ChangeFavoriteProductErrorState());
    });
  }

  ProfileModel? profileModel;

  void getProfile() {
    emit(LoadingGetProfileState());
    DioHelper.getDate(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(GetProfileErrorState());
    });
  }

  ShopLoginModel? registerModel;

  void register(String name, String phone, String email, String password,
      String image) {
    DioHelper.postDate(url: REGISTER, data: {
      'name': name,
      "phone": phone,
      "email": email,
      "password": password,
      "image": image,
    }).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      // if(registerModel!.status == false){
      boast(message: registerModel!.message);
      // }
      emit(RegisterSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(RegisterErrorState());
    });
  }

  void updateProfile(String name, String email, String phone) {
    emit(UpDataLoadingState());
    DioHelper.putDate(
      url: UPDATE,
      token: token,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
      },
    ).then((value) {
      emit(UpDataSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(UpDateErrorState());
    });
  }


  SearchResultModel? searchModel;

  void search(String text) {
    emit(SearchLoadingState());
    if (text.isNotEmpty) {
      DioHelper.postDate(
        url: SEARCH,
        data: {
          "text": text,
        },
        token: token,
      ).then((value) {
        searchModel = SearchResultModel.fromJson(value.data);
        emit(SearchSuccessState());
      }).catchError((err) {
        print(err.toString());
        emit(SearchErrorState());
      });
    }
  }

  CartModel? cart;
  void getCart() {
    emit(GetCartLoadingState());
    DioHelper.getDate(
      url: CART,
      token: token,
    ).then((value) {
      cart = CartModel.fromJson(value.data);
      print(value.data);
      emit(GetCartSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(GetCartErrorState());
    });
  }

  void addRemoveProductToCart(int productId) {
    emit(AddRemoveProductCartLoadingState());
    DioHelper.postDate(
        url: CART,
        token: token,
        data: {
          "product_id": productId,
        }).then((value) {
      getCart();
      emit(AddRemoveProductCartSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(AddRemoveProductCartErrorState());
    });
  }

  // api not responce
  void UpdateCart(int quantity) {
    emit(UpdateProductCartLoadingState());
    DioHelper.postDate(
        url: CART,
        token: token,
        data: {
          "quantity": quantity,
        }).then((value) {
      emit(UpdateProductCartSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(UpdateProductCartErrorState());
    });
  }


  void isConnect(){
    checkConnection().then((value){
      if(value == true)
      {
        online = true;
      }
    });
  }
}

