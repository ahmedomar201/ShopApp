import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/models/login_model.dart';
import 'package:marketapp/login/state_login.dart';
import '../shared/network/remote/dio_helper.dart';
import '../shared/network/remote/end_points.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super(ShopLoginInitialState());
  static  ShopLoginCubit get(context)=>BlocProvider.of(context);

  late ShopLoginModel loginModel;


  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(

      url:LOGIN , data:
    {
      'email':email,
      'password':password,

    },
    ).then((value)
    {
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel.data?.token);
      print(loginModel.message);
      print(loginModel.status);
      print(value.data);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error)
    {
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;

  void changIcon()
  {
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    isPassword=!isPassword;
    emit(ShopChangePasswordVisibilityState());
  }


}
