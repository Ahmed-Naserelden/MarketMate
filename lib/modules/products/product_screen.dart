// ignore_for_file: missing_required_param, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/home_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeDataModel != null,
            builder: (context) => productBuilder(ShopCubit.get(context).homeDataModel!),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state){

        }
    );

  }

  Widget productBuilder(HomeDataModel homeDataModel){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              CarouselSlider(
                items: homeDataModel.data!.banners.map((e) =>
                    Image(image: NetworkImage(e.image.toString()), width: double.infinity,fit: BoxFit.cover),
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,

                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.grey[200],
                child: GridView.count(

                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1 / 1.53,

                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                      homeDataModel.data!.products.length,
                          (index) {
                            return buildGridItem(homeDataModel.data!.products[index]);
                          }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(ProductModel product){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
          Image(

            image: NetworkImage(product.image.toString()),
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.fill,
          ),
          if(product.discount != 0)
          Container(
            height: 15.0,

            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('DISCOUNT', style: TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold),),
          ),
        ],),
        SizedBox(height: 5.0,),
        Text(
          product.name.toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
        Spacer(),
        Row(
          children: [
            Text(
              '${product.price.round()} \$',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            SizedBox(width: 5.0,),
            if(product.discount != 0)
            Text(
              '${product.oldPrice.round()} \$',
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
            Spacer(),
            IconButton(
              onPressed: () {

              },
              icon: true ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_outline, ),
            ),
          ],
        ),

      ],
    );
  }
}
