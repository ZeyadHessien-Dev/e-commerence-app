import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/shared/cubit_main/states.dart';

import '../network/local/cache_helper.dart';
import '../style/theme.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitialMainState());

  static MainCubit get(context) => BlocProvider.of(context);

  ThemeData themeData = lightTheme;
  bool themeIs = true;

  void changeTheme({bool? isShow}) {
    if (isShow != null) {
      themeData = isShow ? darkTheme : lightTheme;
      emit(ChangeThemeMainState());
    }
    else if(isShow == null) {
      themeData = themeIs ? darkTheme : lightTheme;
      CacheHelper.setData(key: 'isDark', value: themeIs);
      themeIs = !themeIs;
      emit(ChangeThemeMainState());
    }
  }
}