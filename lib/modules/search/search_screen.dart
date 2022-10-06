// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/search_result_model.dart';
import 'package:shopping/shared/components/components.dart';

var searchController = TextEditingController();
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        listener: (context, state){

        },
        builder: (context, state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: const Center(
                  child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontSize: 25.0,
                  ),
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      prefixIcon: const Icon(Icons.search),
                      textInputType: TextInputType.text,
                      controller: searchController,
                      validate: (value){
                        if(value.isEmpty){
                          return 'field is Empty';
                        }
                        return null;
                      },
                      text: 'Search',
                      onSubmit: (text){
                        cubit.search(text);
                      }
                  ),
                  const SizedBox(height: 35.0,),
                 if(state is SearchSuccessState)
                 Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index){
                      return ListItem(context, cubit.searchModel!.data!.searchResult[index]);
                    },
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemCount: cubit.searchModel!.data!.searchResult.length,
                  ),
                ),
                ],
              ),
            ),
          );
        },
    );
  }

  Widget buildGridItem(context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${product.image}'),
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.fill,
            ),
          ],
        ),
        const SizedBox(height: 5.0,),
        Text(
          product.name.toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          '${product.description}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(),
        ),
        const Spacer(),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          // textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${product.price!.round()} \$',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(width: 5.0,),

            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              // constraints: BoxConstraints(),
              onPressed: () {
                print(product.id);
              },
              icon: const Icon(
                Icons.add_circle_outlined, color: Colors.deepOrange,
                size: 30.0,),
            ),

            IconButton(
              padding: EdgeInsets.zero,
              // constraints: BoxConstraints(),
              onPressed: () {
                print(product.id);

              },
              icon:  Icon(Icons.add_circle_outlined, color: Colors.deepOrange, size: 30.0,),
            ),

            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                print(product.id);
                ShopCubit.get(context).changeFavoriteProduct(product.id!);
              },
              icon: ShopCubit.get(context).isInFavorite[product.id] == true ? Icon(Icons.favorite, color: Colors.red,size: 25.0,) : Icon(Icons.favorite_outline, size: 25.0,),
            ),
            const SizedBox(width: 10.0,)
          ],
        ),

      ],
    );
  }

  Widget ListItem(context,Product product){
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
                  image: NetworkImage('${product.image}'),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fill,
                ),
              ],),

            const SizedBox(width: 10.0,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                          child: Text('${product.price} \$',
                            style: const TextStyle(
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0,),

                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          // constraints: BoxConstraints(),
                          onPressed: () {
                            // print(product.id);
                          },
                          icon:  Icon(Icons.add_circle_outlined, color: Colors.deepOrange, size: 30.0,),
                        ),

                        IconButton(
                          padding: EdgeInsets.zero,
                          // constraints: BoxConstraints(),
                          onPressed: () {
                            // print(product.id);
                            ShopCubit.get(context).changeFavoriteProduct(product.id!);
                            // ShopCubit.get(context).changeFavoriteProduct(product.id!);
                          },
                          icon: ShopCubit.get(context).isInFavorite[product.id] == true ? Icon(Icons.favorite, color: Colors.red,size: 25.0,) : Icon(Icons.favorite_outline, size: 25.0,),
                        ),
                      ],
                    ),
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
