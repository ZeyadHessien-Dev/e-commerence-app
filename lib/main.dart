import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/cubit.dart';
import 'package:shop_application/layout/shop_layout/layout_screen.dart';
import 'package:shop_application/module/home/home_screen.dart';
import 'package:shop_application/module/login/login_cubit/cubit.dart';
import 'package:shop_application/module/login/login_screen.dart';
import 'package:shop_application/shared/bloc_observer.dart';
import 'package:shop_application/shared/components/constants.dart';
import 'package:shop_application/shared/cubit_main/cubit.dart';
import 'package:shop_application/shared/cubit_main/states.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';
import 'package:shop_application/shared/network/remote/dio_helper.dart';
import 'package:shop_application/shared/style/theme.dart';
import 'module/on_boarding/onboarding_screen.dart';
import 'module/register/register_cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget startWidget;
  bool? onBoarding = CacheHelper.getBoolData(key: 'onBoarding');
  bool? isDark = CacheHelper.getBoolData(key: 'isDark');
  token = CacheHelper.getStringData(key: 'token');
  if (onBoarding == true) {
    if (token != null) {
      startWidget = ShopLayoutScreen();
    } else {
      startWidget = LoginScreen();
    }
  }
  else {
    startWidget = OnBoardingScreen();
  }
  runApp(MyApp(startWidget,isDark!));
}


class MyApp extends StatelessWidget {
  Widget startWidget;
  bool isDark;
  MyApp(this.startWidget,this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopLayoutCubit()..getHomeData()..getCategoriesData()..getProfile()..getFavorites()),
        BlocProvider(create: (context) => LoginShopLayoutCubit()),
        BlocProvider(create: (context) => RegisterShopLayoutCubit()),
        BlocProvider(
          create: (context) => MainCubit()..changeTheme(
            isShow: isDark,
          ),
        ),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            theme: MainCubit.get(context).themeData,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
