import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/profile_model.dart';
import 'package:shopping/modules/cart/CartScreen.dart';
import 'package:shopping/modules/login/login_screen.dart';
import 'package:shopping/modules/search/search_screen.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/components/constants.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            leading: IconButton(
              onPressed: (){
                logoutFunction(context);
              },
              icon: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
            ),
            title: const Center(
              child: Text('House Ware',style: TextStyle(
                color: Colors.white,
              ),),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigatTo(context, const SearchScreen());
                },
                icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: (){
                  navigatTo(context, const CartScreen());
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),





          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            items:  const [
              BottomNavigationBarItem(
                  icon:  Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon:  Icon(Icons.apps),
                  label: 'Categories',
              ),
              BottomNavigationBarItem(
                  icon:  Icon(Icons.favorite),
                  label: 'Favorites',
              ),
              BottomNavigationBarItem(
                  icon:  Icon(Icons.settings),
                  label: 'Settings',
              ),
            ],
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }

  void logoutFunction(context){
    token="";
    CachHelper.removeKey(key: 'token').then((value) {
      navigateAndFinish(context, const LoginScreen());
    });
  }
}
