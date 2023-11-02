import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/shared/components/constant.dart';
import 'package:shop_application/shared/cubit/cubit.dart';
import 'package:shop_application/shared/cubit/states.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';
import 'package:shop_application/shared/network/remote/dio_helper.dart';
import 'package:shop_application/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/shop_login_screen/shop_login_screen.dart';

void main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key:'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key:'onBoarding');
  token = CacheHelper.getData(key:'token');
  print(token);

  if(onBoarding != null)
  {
    if(token != null)
    {
      widget = ShopLayout();
    }else
    {
      widget = ShopLoginScreen();
    }
  }else
  {
    widget = OnBoardingScreen();
  }
  print(onBoarding);

  runApp (MyApp(
    isDark: isDark,
    startWidget: widget ,
  ));
}


class MyApp extends StatelessWidget{
  bool? isDark;
  Widget? startWidget;
  MyApp( {
    required this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>AppCubit()..changeAppMode(
            fromShared: isDark,
          ),),
        BlocProvider(
            create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()

        ),
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state) {},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false ,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light, //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

            home:startWidget,
            //home:LoginPage(),
            // Directionality(
            //     textDirection: TextDirection.ltr,
            //   child: startWidget,
            // ),
          );
        },
      ),
    );
  }

}
