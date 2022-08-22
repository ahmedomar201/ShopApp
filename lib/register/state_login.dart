


import '../models/profile_model.dart';

abstract class ShopRegisterStates{
}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  late final ProfileModel registerModel;
  ShopRegisterSuccessState( this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error ;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}
