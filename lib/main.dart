import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/layout/shop_layout.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/login/shop_login.dart';
import 'package:marketapp/onboarding/onboarrding.dart';
import 'package:marketapp/shared/componets/tasks.dart';
import 'package:marketapp/shared/network/local/cash_helper.dart';
import 'package:marketapp/shared/style/theme.dart';
import 'bloc_observer.dart';
import 'shared/network/remote/dio_helper.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized() بتخلي الحاجات اللي بعديها تتنفذ
  // وبعد كدة يعمل run
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

 // bool isDark=CacheHelper.getData(key:"isDark");
  bool? onBoarding=CacheHelper.getData(key:"OnBoarding");
  token=CacheHelper.getData(key:"token");
  print(token);

 late Widget widget;
  //print(onBoarding);
if(onBoarding!=null)
{
  if(token!=null)
    widget=ShopLayout();
  else widget=ShopLoginScreen();
}else
{
  widget=OnBoardingScreen();
}

      runApp(MyApp(
        //isDark: isDark,
        startWidget: widget,
      ));



}
class MyApp extends StatelessWidget {
 // late final bool isDark;
  late final Widget startWidget ;
  //required this.isDark
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>
        ShopLayoutCubit()..getHomeData()..getCategories()..getFavourites()..userModelData(),
        child: BlocConsumer<ShopLayoutCubit,ShopStates>
        (
        listener:(context,state){},
        builder: (context,state)=>MaterialApp(
         theme:lightTheme,
         darkTheme: darkTheme,
         //themeMode:NewsCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light,
        debugShowCheckedModeBanner: false,
          home:startWidget,
    ),
    ),
    );

          }
  }
