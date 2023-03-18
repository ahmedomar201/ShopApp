import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/models/categories_model.dart';
import 'package:marketapp/models/changefavouritemodel.dart';
import 'package:marketapp/models/favorits_model.dart';
import 'package:marketapp/models/profile_model.dart';
import 'package:marketapp/models/home_model.dart';
import 'package:marketapp/shared/componets/tasks.dart';
import '../modules/cateogries/cateogries_screen.dart';
import '../modules/favorites/favorites_screen.dart';
import '../modules/products/products_screen.dart';
import '../modules/search/search_screen.dart';
import '../modules/setting/setting_screen.dart';
import '../shared/network/remote/dio_helper.dart';
import '../shared/network/remote/end_points.dart';

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


    homeModel?.data.products.forEach((element){
      favorites?.addAll({
        element.id:element.inFavorites!,
      });

    });
    emit(ShopSuccessHomedDataStates());
  }
  ).
  catchError((error) {

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

      }else
      {
        getFavourites();
      }

    }).catchError((error)
    {
      favorites![productId]=!favorites![productId]!;

      emit(ShopErrorChangeFavoritesStates());
    });
  }



  FavoritesModel?favoritesModel;
  void getFavourites() {

    emit(ShopLoadingFavoritesStates());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).
    then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);

      emit(ShopSuccessFavoritesStates());
    }
    ).
    catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesStates());
    }
    );
  }



  ProfileModel?userModel;
  void userModelData() {

    emit(ShopLoadingUserDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).
    then((value) {
      userModel=ProfileModel.fromJson(value.data);

      emit(ShopSuccessUserDataStates(userModel!));
    }
    ).
    catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStates());
    }
    );
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone
  }) {

    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,

      }
    ).
    then((value) {
      userModel=ProfileModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserStates(userModel!));
    }
    ).
    catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserStates());
    }
    );
  }



}









