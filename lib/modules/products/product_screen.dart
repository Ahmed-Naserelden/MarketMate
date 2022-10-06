// ignore_for_file: missing_required_param, prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping/layout/home_layout/cubit/shop_cubit.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/models/home_model.dart';
import 'package:shopping/shared/components/components.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStatus>(
        builder: (context, state){
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeDataModel != null && ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productBuilder(ShopCubit.get(context).homeDataModel!, context),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state){
          if (state is ChangeFavoriteProductSuccessState && state.model.status == false){
            boast(message: state.model.message, gravity: ToastGravity.BOTTOM,);
          }
        }
    );
  }

  Widget productBuilder(HomeDataModel homeDataModel, context){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 10.0,),
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index) {
                    return categoryItem(ShopCubit.get(context).categoriesModel!.categoriesData!.data[index]);
                  },
                  separatorBuilder: (context , index){
                    return SizedBox(width: 10);
                  },
                  itemCount: ShopCubit.get(context).categoriesModel!.categoriesData!.data.length,
              ),
            ),
            SizedBox(height: 20.0,),
            Center(
              child: Text(
                'New Products',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.deepOrange,
                  // fontWeight: FontWeight.w800,
                ),
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
                          return buildGridItem(context, homeDataModel.data!.products[index]);
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridItem(context, ProductModel product){
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
              padding: EdgeInsets.zero,
              // constraints: BoxConstraints(),
              onPressed: () {
                print(product.id);
                ShopCubit.get(context).addRemoveProductToCart(product.id!);
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
            SizedBox(width: 10.0,),

          ],
        ),

      ],
    );
  }

  Widget categoryItem(Data data){
    return  Container(
      width: 100.0,
      height: 100.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${data.image}'),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            child: Text(
              '${data.name}',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Colors.black.withOpacity(0.8),
          ),
        ],
      ),
    );

  }
}
