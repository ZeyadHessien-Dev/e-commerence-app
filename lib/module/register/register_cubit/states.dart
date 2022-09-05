import '../../../model/register_model.dart';

abstract class RegisterShopLayoutStates {}
class RegisterInitialShopLayoutState extends RegisterShopLayoutStates {}
class RegisterChangePasswordState extends RegisterShopLayoutStates {}



// APIS
class LoadingRegisterUserState extends RegisterShopLayoutStates {}
class SuccessRegisterUserState extends RegisterShopLayoutStates {
  RegisterModel registerModel;
  SuccessRegisterUserState(this.registerModel);
}

class ErrorRegisterUserState extends RegisterShopLayoutStates {
  final String error;
  ErrorRegisterUserState(this.error);
}
