import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/layout/home_layout/cubit/shop_status.dart';

class ShopCubit extends Cubit<ShopStatus>{
  ShopCubit() : super(ShopInitialStatus());
  static ShopCubit get(context) => BlocProvider.of(context);


}