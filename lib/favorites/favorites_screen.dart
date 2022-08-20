import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/colors.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/models/favorits_model.dart';
import 'package:marketapp/tasks.dart';
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
                itemBuilder:(context,index)=>buildFavItem(ShopLayoutCubit.get(context).favoritesModel!.data.data[index],context),
                separatorBuilder: (context,index)=>myDivider(),
                itemCount:ShopLayoutCubit.get(context).favoritesModel!.data.data.length),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
    );
  }
  Widget buildFavItem(FavoritesData model,context)=> Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image:NetworkImage(
                    model.product.image!,
                  ),
                  width:120,
                  height: 120,
                ),
                if(model.product.discount!=0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'Discount',
                      style: TextStyle(
                        fontSize:15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                  )
              ]
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.product.name!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product.price.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: defaultColor
                      ),),
                    SizedBox(
                      width: 5,
                    ),
                    if(model.product.discount!=0)
                      Text(
                        model.product.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),),
                    Spacer(),
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor:ShopLayoutCubit.get(context).favorites![ model.product.id]!?defaultColor:Colors.grey,
                        //ShopLayoutCubit.get(context).favorites![model.id]!?defaultColor:
                        radius: 15,
                        child: Icon(
                          size:14,
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: ()
                      {
                         ShopLayoutCubit.get(context).changeFavorites(model.product.id!);
                        // print(model.id);
                      },)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
