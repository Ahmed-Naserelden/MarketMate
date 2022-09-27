import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/modules/login/login_screen.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
          ),
          body: Center(
            child: TextButton(
              child: const Text('Log out'),
              onPressed: (){
                CachHelper.removeKey(key: 'token').then((value) {
                  navigateAndFinish(context, const LoginScreen());
                });

          },),),
        );
      },
    );

  }
}
