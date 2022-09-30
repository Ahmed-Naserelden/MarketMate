import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeDataModel != null,
            builder: (context) => productBuilder(),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state){

        }
    );

  }

  Widget productBuilder(){
    return Column(
      children: const [

      ],
    );
  }

}
