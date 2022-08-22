import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/shared/componets/tasks.dart';
class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopLayoutCubit,ShopStates>
      (
      listener: (context,state){},
      builder:(context,state)=>
          BuildCondition(
            condition:state is! ShopLoadingFavoritesStates,
            builder:(context)=> ListView.separated(
                itemBuilder:(context,index)=>buildListProduct(ShopLayoutCubit.get(context).favoritesModel!.data.data[index].product,context),
                separatorBuilder: (context,index)=>myDivider(),
                itemCount:ShopLayoutCubit.get(context).favoritesModel!.data.data.length),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
    );
  }

}
