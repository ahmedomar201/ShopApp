import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/models/profile_model.dart';
import 'package:marketapp/modules/register/state_login.dart';
import 'package:marketapp/shared/network/remote/dio_helper.dart';

import '../../shared/network/remote/end_points.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());
  static  ShopRegisterCubit get(context)=>BlocProvider.of(context);

   ProfileModel? registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(

      url:REGISTER,
      data:
    {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,

    },
    ).then((value)
    {
      registerModel=ProfileModel.fromJson(value.data);


      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error)
    {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;

  void changIconRegister()
  {
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    isPassword=!isPassword;
    emit(ShopRegisterChangePasswordVisibilityState());
  }


}

