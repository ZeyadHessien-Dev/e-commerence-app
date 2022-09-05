import '../../../model/login_model.dart';

abstract class LoginShopLayoutStates {}
class LoginInitialShopLayoutState extends LoginShopLayoutStates {}
class LoginChangePasswordState extends LoginShopLayoutStates {}



// APIS
class LoadingLoginUserState extends LoginShopLayoutStates {}
class SuccessLoginUserState extends LoginShopLayoutStates {
  LoginModel loginModel;
  SuccessLoginUserState(this.loginModel);
}

class ErrorLoginUserState extends LoginShopLayoutStates {
  final String error;
  ErrorLoginUserState(this.error);
}
