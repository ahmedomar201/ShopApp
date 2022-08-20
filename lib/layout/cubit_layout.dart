import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/cateogries/cateogries_screen.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/models/categories_model.dart';
import 'package:marketapp/models/changefavouritemodel.dart';
import 'package:marketapp/network/remote/dio_helper.dart';
import 'package:marketapp/network/remote/end_points.dart';
import 'package:marketapp/favorites/favorites_screen.dart';
import 'package:marketapp/models/home_model.dart';
import 'package:marketapp/products/products_screen.dart';
import 'package:marketapp/search/search_screen.dart';
import 'package:marketapp/setting/setting_screen.dart';
import 'package:marketapp/tasks.dart';


class ShopLayoutCubit extends Cubit<ShopStates>
{
  ShopLayoutCubit():super (ShopInitialLayoutStates());
  static ShopLayoutCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<Widget>bottomScreen=
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
    SearchScreen(),
  ];
void changeBottom(int index)
{
  currentIndex=index;
  emit(ShopChangeBottomNavLayoutStates());
}
      Map<int,bool>?favorites={};
   HomeModel? homeModel;
void getHomeData() {
  emit(ShopLoadingHomedDataStates());

  DioHelper.getData(
      url: HOME,
      token:token ).
  then((value) {
    homeModel=HomeModel.fromJson(value.data);
    // print(homeModel?.status);
    // printFullText(homeModel.toString());

    homeModel?.data.products.forEach((element){
      favorites?.addAll({
        element.id:element.inFavorites!,
      });
      print(favorites.toString());
    });
    emit(ShopSuccessHomedDataStates());
  }
  ).
  catchError((error) {
    print(error.toString());
    emit(ShopErrorHomedDataStates());
  }
  );
}
  CategoriesModel? categoriesModel;
  void getCategories() {

    DioHelper.getData(
        url: GET_CATEGORIES,
        ).
    then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      //print(homeModel.status);
      //printFullText(categoriesModel.toString());
      emit(ShopSuccessCategoriesStates());
    }
    ).
    catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    }
    );
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites![productId]=!favorites![productId]!;
    emit(ShopChangeFavoritesStates ());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':productId,
      },
      token:token,
    ).
    then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
      if(!changeFavoritesModel!.status!)
      {
        favorites![productId]=!favorites![productId]!;

      }

    }).catchError((error)
    {
      favorites![productId]=!favorites![productId]!;

      emit(ShopErrorChangeFavoritesStates());
    });
  }
}









