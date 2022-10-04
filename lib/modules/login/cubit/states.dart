import 'package:shopping/models/login_model.dart';

abstract class ShopLoginStates{}

class InitialState extends ShopLoginStates{}

class ShowPasswordState extends ShopLoginStates{}

class SuccessLogin extends ShopLoginStates{
  final ShopLoginModel shopLoginModel;
  SuccessLogin(this.shopLoginModel);
}

class FailureLogin extends ShopLoginStates{}

class ErrorLogin extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}



