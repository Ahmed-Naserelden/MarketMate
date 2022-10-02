import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                return categoriesItem(ShopCubit.get(context).categoriesModel!.categoriesData!.data[index]);
                },
              separatorBuilder: (context, index) {
                return Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 350.0,
                    height: 1.0,
                    color: Colors.grey,
                    ),
                    const Spacer(),
                  ],
                );
                },
              itemCount: ShopCubit.get(context).categoriesModel!.categoriesData!.data.length,
          );
        },
        listener: (context, state){

        }
    );
  }

  Widget categoriesItem(Data data){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${data.image}'),
            fit: BoxFit.cover,
            height: 100.0,
            width: 100.0,
          ),
          const SizedBox(width: 20.0,),
          Text(
            '${data.name}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
