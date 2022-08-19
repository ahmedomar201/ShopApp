import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/colors.dart';
import 'package:marketapp/models/categories_model.dart';
import 'package:marketapp/models/home_model.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/tasks.dart';
class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopSuccessChangeFavoritesStates) {
          if (!state.model.status!) 
          {
            showToast(
                text: state.model.message!,
                state: ToastStates.ERROR);

          }
        }
      },
      builder: (context,state)
      {
        //ConditionalBuilder
        // condition: ShopLayoutCubit.get(context).addCartModel!=null,
        // fallback: (context)=>Center(child: CircularProgressIndicator()),);
        return BuildCondition(
          condition: ShopLayoutCubit.get(context).homeModel!=null
              &&ShopLayoutCubit.get(context).categoriesModel!=null,
          builder:(context)=> productsBuilder(ShopLayoutCubit.get(context).homeModel!,
              ShopLayoutCubit.get(context).categoriesModel!,context),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
  });
  }
}
Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items: model.data.banners.map((e)=>
              Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
               )).toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal
          )),
      SizedBox(
        height: 10,),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),),
            SizedBox(
              height: 10,),
            Container(
              height: 100,
              child: ListView.separated(
                physics:BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder:(context,index)=>buildCategoriesItem(categoriesModel.data.data[index]),
                  separatorBuilder: (context,index)=>SizedBox(
                    width: 10,
                  ),
                  itemCount: categoriesModel.data.data.length),
            ),
            SizedBox(
              height: 10,),
            Text('New Products',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),),
          ],
        ),
      ),
      SizedBox(
        height: 20,),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap:true,
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.59,
          children: List.generate(model.data.products.length,
                  (index) =>buildGridProducts(model.data.products[index],context)
          ),
        ),
      ),
    ],
  ),
);

Widget buildCategoriesItem( DataModel model)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(image:NetworkImage(model.image),
      height:100 ,
      width:100,
      fit: BoxFit.cover,),
    Container(
      color: Colors.black.withOpacity(0.8),
      width: 100,
      child: Text(
        model.name,
        textAlign:TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  ],
);

Widget buildGridProducts(ProductsModel model,context)=>Container(
  color: Colors.white,
  child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
         Image(
          image:NetworkImage(
              model.image,
          ),
          width: double.infinity,
          height: 200,
        ),
          if(model.discount!=0)
          Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Discount',
            style: TextStyle(
              fontSize:15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
          )
          ]
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),),
            Row(
              children: [
                Text(
                 '${model.price.round()}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: defaultColor
                  ),),
                SizedBox(
                  width: 5,
                ),
                if(model.discount!=0)
                Text(
                  '${model.oldPrice.round()}',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    decoration: TextDecoration.lineThrough
                  ),),
                Spacer(),
                IconButton(
                    icon: CircleAvatar(
                      backgroundColor:ShopLayoutCubit.get(context).favorites[model.id]!?defaultColor:Colors.grey,
                      radius: 15,
                      child: Icon(
                        size:14,
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  onPressed: ()
                  {
                    ShopLayoutCubit.get(context).changeFavorites(model.id);
                    print(model.id);
                  },)
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);


