// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketapp/layout/cubit_layout.dart';
import 'package:marketapp/layout/shop_layout.dart';
import 'package:marketapp/layout/states_layout.dart';
import 'package:marketapp/login/shop_login.dart';
import 'package:marketapp/onboarrding.dart';
import 'package:marketapp/tasks.dart';
import 'package:marketapp/theme.dart';
import 'bloc_observer.dart';
import 'network/local/cash_helper.dart';
import 'network/remote/dio_helper.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized() بتخلي الحاجات اللي بعديها تتنفذ
  // وبعد كدة يعمل run
  DioHelper.init();
  await CacheHelper.init();

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
  BlocOverrides.runZoned(
        () {
      // Use blocs...
      runApp(MyApp(
        //isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
 // late final bool isDark;
  late final Widget startWidget ;
  //required this.isDark
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ShopLayoutCubit()..getHomeData()..getCategories(),
        child: BlocConsumer<ShopLayoutCubit,ShopStates>
        (
        listener:(context,state){},
        builder: (context,state)=>MaterialApp(
         theme:lightTheme,
         darkTheme: darkTheme,
         //themeMode:NewsCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light,
        debugShowCheckedModeBanner: false,
          home:startWidget,
          //startWidget
          //ShopLayout()
    ),
    ),
    );

          }
  }

// MultiBlocProvider(
// providers: [
// //BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getScience()..getSports(),),
// //BlocProvider(create: (context)=>NewsCubit()..changeAppMode(fromShared:isDark)),
// ],

//
