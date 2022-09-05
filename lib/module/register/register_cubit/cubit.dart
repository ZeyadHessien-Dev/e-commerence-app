import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/module/register/register_cubit/states.dart';
import 'package:shop_application/shared/network/remote/dio_helper.dart';
import '../../../model/register_model.dart';
import '../../../shared/network/end_point.dart';

class RegisterShopLayoutCubit extends Cubit<RegisterShopLayoutStates> {
  RegisterShopLayoutCubit() : super(RegisterInitialShopLayoutState());

  static RegisterShopLayoutCubit get(context) => BlocProvider.of(context);

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
    emit(RegisterChangePasswordState());
  }

  RegisterModel? registerModel;
  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(LoadingRegisterUserState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(SuccessRegisterUserState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegisterUserState(error.toString()));
    });
  }
}
