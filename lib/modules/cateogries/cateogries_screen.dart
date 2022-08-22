import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/models/categories_model.dart';
import 'package:marketapp/shared/componets/tasks.dart';
class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>
      (
        listener: (context,state){},
        builder:(context,state)=>
            ListView.separated(
                itemBuilder:(context,index)=>buildCatItem(
                    ShopLayoutCubit.get(context).categoriesModel!.data.data[index]
                ),
                separatorBuilder: (context,index)=>myDivider(),
                itemCount:ShopLayoutCubit.get(context).categoriesModel!.data.data.length),
        );
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image:NetworkImage(model.image),
          fit: BoxFit.cover,
          height: 80,
          width: 80,),
        SizedBox(
          width: 20,
        ),
        Text(model.name,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,),
      ],
    ),
  );
}




