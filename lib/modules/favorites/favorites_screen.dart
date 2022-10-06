// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/favorites_model.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
          return ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index){
                // return Container();
                return ListItem(ShopCubit.get(context).favoriteProducts!.data!.data!.data[index].product!, context);

              },
              separatorBuilder: (context, index){
                return Container(
                  height: 1.0,
                  color: Colors.grey,
                );
              },
              itemCount: ShopCubit.get(context).favoriteProducts!.data!.data!.data.length,
          );
        },
        listener: (context, state){}
    );
  }

  Widget ListItem(Product favoriteProduct, context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${favoriteProduct.image}'),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fill,
                ),
                if(favoriteProduct.discount != 0)
                Container(
                  height: 15.0,
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text('DISCOUNT', style: TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ],),
            const SizedBox(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${favoriteProduct.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${favoriteProduct.price}',
                        style: const TextStyle(
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      if(favoriteProduct.discount != 0)
                      Text(
                        '${favoriteProduct.oldPrice} \$',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                          decoration: TextDecoration.lineThrough,

                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavoriteProduct(favoriteProduct.id!);
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
