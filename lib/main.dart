import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/layout/home_layout/shop_layout.dart';
import 'package:shopping/modules/login/cubit/loginCubit.dart';
import 'package:shopping/modules/login/login_screen.dart';
import 'package:shopping/modules/on_boarding/on_boarding_screen.dart';
import 'package:shopping/modules/register/register.dart';
import 'package:shopping/shared/bloc_observer.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';
import 'package:shopping/shared/styles/themes.dart';

import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (BuildContext context) =>
          ShopCubit()
          ..start()..getHomeData(),),
      ],
      //create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopCubit, ShopStatus>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = ShopCubit.get(context);
          bool onBoarding = cubit.onBoarding;
          String token = cubit.token;



          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWithWidget(onBoarding, token),
          );
        },
      ),);
  }


  Widget startWithWidget(bool onBoarding, login){
    if(onBoarding){
      if(login != null){
        return const ShopLayout();
      }
      return const LoginScreen();
    }
    return const OnBoardingScreen();
  }

}