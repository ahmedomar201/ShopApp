import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/cateogries/cateogries_screen.dart';
import 'package:marketapp/models/categories_model.dart';
import 'package:marketapp/network/remote/dio_helper.dart';
import 'package:marketapp/network/remote/end_points.dart';
import 'package:marketapp/favorites/favorites_screen.dart';
import 'package:marketapp/models/home_model.dart';
import 'package:marketapp/products/products_screen.dart';
import 'package:marketapp/search/search_screen.dart';
import 'package:marketapp/setting/setting_screen.dart';
import '../tasks.dart';
import 'states_layout.dart';

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
      Map<int,bool>?favorite={};
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

    homeModel?.data?.products.forEach((element){
      favorite?.addAll({
        element.id:element.inFavorites,
      });
      print(favorite.toString());
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
}






