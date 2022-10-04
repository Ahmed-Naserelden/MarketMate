import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';

import '../../layout/home_layout/cubit/shop_status.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
          return ConditionalBuilder(
              condition: true,
              builder: (context) => Scaffold(
                appBar: AppBar(),
                body: ListView.separated(
                    itemBuilder: (context, index) => cartItems(),
                    separatorBuilder: (context, index) => Container(height: 1, color: Colors.grey,),
                    itemCount: 10,
            ),
              ),
          );
        },
        listener: (context, state){}
    );
  }
}

Widget cartItems(){
  return Container();
}
