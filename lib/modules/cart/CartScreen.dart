import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/shared/components/constants.dart';

import '../../layout/home_layout/cubit/shop_status.dart';
import '../../models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
          var cubit = ShopCubit.get(context);

          return  Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: const Center(
                child: Text(
                    'Cart',
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
            body: ConditionalBuilder(
              condition: cubit.online,
              builder: (context) => ConditionalBuilder(
                condition: cubit.cart!.data!.cartItems.isNotEmpty,
                fallback: (context) => dataEmpty("Cart Is Empty !"),
                builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Total Price : ${cubit.cart!.data!.total}',style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),),
                    Center(
                      child: Text.rich(
                          TextSpan(
                            text: 'Total Price : ',
                            style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 22.0),
                            children: [
                              TextSpan(
                                text: '${cubit.cart!.data!.total}',
                                style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold,),
                              ),
                            ],
                          )
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => ListItem(context, cubit.cart!.data!.cartItems[index]),
                        separatorBuilder: (context, index) => Column(
                          children: [
                            Container(height: 1, color: Colors.grey,),
                            const SizedBox(height: 10.0,),
                          ],
                        ),
                        itemCount: cubit.cart!.data!.cartItems.length,
                      ),
                    ),
                  ],
                ),
              ),
              ),
              fallback: (context) => offline(),
            ),
          );
        },
        listener: (context, state){}
    );
  }
}

Widget ListItem(context, Order order){
  return Container(
    height: 100.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${order.product!.image}'),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.fill,
            ),
          ],),
        const SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                '${order.product!.name}',
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
                    '${order.product!.price} \$',
                    style: const TextStyle(
                    ),
                  ),
                  const SizedBox(width: 5.0,),
                  const Spacer(),
                  TextButton(onPressed: (){
                    ShopCubit.get(context).addRemoveProductToCart(order.product!.id);
                  }, child: const Text('Remove',),),
                  const SizedBox(width: 5.0,),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavoriteProduct(order.product!.id);
                    },
                    icon: ShopCubit.get(context).isInFavorite[order.product!.id] == true ? const Icon(Icons.favorite, color: Colors.red,size: 25.0,) : const Icon(Icons.favorite_outline, size: 25.0,),
                  ),
                  const SizedBox(width: 5.0,),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}