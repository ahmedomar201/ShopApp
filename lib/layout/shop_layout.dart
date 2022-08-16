import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/search/search_screen.dart';
import 'states_layout.dart';
class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>
      (
      listener:(context,state){},
      builder: (context,state){
        var cubit= ShopLayoutCubit.get(context) ;

        return Scaffold(
        appBar: AppBar(
          title: Expanded(
            child: Text('Salla',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),),
          ),
          actions: [
            IconButton(
             icon:Icon(
             Icons.search ),
              onPressed:()
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
                ),
          ],
        ),
        body: cubit.bottomScreen[
          cubit.currentIndex
        ],
          bottomNavigationBar: BottomNavigationBar(
            onTap:(index)
            {
              cubit.changeBottom(index);
            } ,
            currentIndex:cubit.currentIndex,

            items: [
              BottomNavigationBarItem(icon: Icon(
                Icons.home
              ),label: 'Home',),
              BottomNavigationBarItem(icon: Icon(
                  Icons.apps
              ),label: 'categories'),
              BottomNavigationBarItem(icon: Icon(
                  Icons.favorite
              ),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(
                  Icons.settings
              ),label: 'Settings'),
            ],
          ),

      );
  }
    );
  }
  }

// TextButton(
// onPressed: ()
// {
//
// },
// child: Text('SIGN OUT'),
// ),