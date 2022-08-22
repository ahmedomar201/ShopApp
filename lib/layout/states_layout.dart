import 'package:marketapp/models/changefavouritemodel.dart';
import 'package:marketapp/models/profile_model.dart';

abstract class ShopStates{}


class ShopInitialLayoutStates extends ShopStates{}


class ShopChangeBottomNavLayoutStates extends ShopStates{}

class ShopLoadingHomedDataStates extends ShopStates{}
class ShopSuccessHomedDataStates extends ShopStates{}
class ShopErrorHomedDataStates extends ShopStates{}



class ShopSuccessCategoriesStates extends ShopStates{}
class ShopErrorCategoriesStates extends ShopStates{}

class ShopChangeFavoritesStates extends ShopStates{}
class ShopSuccessChangeFavoritesStates extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}
class ShopErrorChangeFavoritesStates extends ShopStates{}

class ShopLoadingFavoritesStates extends ShopStates{}
class ShopSuccessFavoritesStates extends ShopStates{}
class ShopErrorFavoritesStates extends ShopStates{}


class ShopLoadingUserDataStates extends ShopStates{}

class ShopSuccessUserDataStates extends ShopStates
{
  final ProfileModel  loginModel;

  ShopSuccessUserDataStates(this.loginModel);
}
class ShopErrorUserDataStates extends ShopStates{}



class ShopLoadingUpdateUserStates extends ShopStates{}

class ShopSuccessUpdateUserStates extends ShopStates
{
  final ProfileModel  loginModel;

  ShopSuccessUpdateUserStates(this.loginModel);
}
class ShopErrorUpdateUserStates extends ShopStates{}

