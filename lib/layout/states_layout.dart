import 'package:marketapp/models/changefavouritemodel.dart';

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
