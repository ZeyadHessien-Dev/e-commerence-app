import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/model/login_model.dart';
import 'package:shop_application/module/login/login_cubit/states.dart';
import 'package:shop_application/shared/network/remote/dio_helper.dart';
import '../../../shared/network/end_point.dart';

class LoginShopLayoutCubit extends Cubit<LoginShopLayoutStates> {
  LoginShopLayoutCubit() : super(LoginInitialShopLayoutState());

  static LoginShopLayoutCubit get(context) => BlocProvider.of(context);

  bool isShow = true;
  Icon iconShow = const Icon(
    Icons.visibility,
  );

  void changePassword() {
    iconShow = isShow
        ? const Icon(
      Icons.visibility_off,
    )
        : const Icon(
      Icons.visibility,
    );
    isShow = !isShow;
    emit(LoginChangePasswordState());
  }

  LoginModel? loginModel;
  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoadingLoginUserState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email' : email,
        'password' : password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(SuccessLoginUserState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoginUserState(error.toString()));
    });
  }
}
