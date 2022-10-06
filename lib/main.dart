import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import 'shared/components/constants.dart';
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
          ShopCubit()..start(),),
      ],
      //create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopCubit, ShopStatus>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = ShopCubit.get(context);
          bool onBoarding = cubit.onBoarding;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // fontFamily: 'Jannah',
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false, // to me able to edit

                iconTheme: IconThemeData(color: Colors.black),

                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),

                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle:  SystemUiOverlayStyle(
                  // this related with the above appbar that located in wifi and battery icons that is status bar

                  statusBarColor: Color.fromARGB(30, 200,71,71),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),

              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),

              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0
              ),

              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

            ),
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