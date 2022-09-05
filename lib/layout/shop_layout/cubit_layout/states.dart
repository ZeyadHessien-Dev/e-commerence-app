import 'package:shop_application/model/favorites_model.dart';

abstract class ShopLayoutStates {}
class InitialShopLayoutState extends ShopLayoutStates {}
class ChangeBottomNavigatorState extends ShopLayoutStates {}


// APIS
class LoadingGetHomeState extends ShopLayoutStates {}
class SuccessGetHomeState extends ShopLayoutStates {}
class ErrorGetHomeState extends ShopLayoutStates {
  final String error;
  ErrorGetHomeState(this.error);
}


class LoadingGetCategoriesState extends ShopLayoutStates {}
class SuccessGetCategoriesState extends ShopLayoutStates {}
class ErrorGetCategoriesState extends ShopLayoutStates {
  final String error;
  ErrorGetCategoriesState(this.error);
}

class LoadingSearchState extends ShopLayoutStates {}
class SuccessSearchState extends ShopLayoutStates {}
class ErrorSearchState extends ShopLayoutStates {
  final String error;
  ErrorSearchState(this.error);
}


class LoadingGetProfileState extends ShopLayoutStates {}
class SuccessGetProfileState extends ShopLayoutStates {}
class ErrorGetProfileState extends ShopLayoutStates {
  final String error;
  ErrorGetProfileState(this.error);
}


class LoadingUpdateProfileState extends ShopLayoutStates {}
class SuccessUpdateProfileState extends ShopLayoutStates {}
class ErrorUpdateProfileState extends ShopLayoutStates {
  final String error;
  ErrorUpdateProfileState(this.error);
}

class LoadingFavoritesState extends ShopLayoutStates {}
class SuccessFavoritesState extends ShopLayoutStates {
  FavoritesModel favoritesModel;
  SuccessFavoritesState(this.favoritesModel);
}
class ErrorFavoritesState extends ShopLayoutStates {
  final String error;
  ErrorFavoritesState(this.error);
}



class LoadingGetFavoritesState extends ShopLayoutStates {}
class SuccessGetFavoritesState extends ShopLayoutStates {}
class ErrorGetFavoritesState extends ShopLayoutStates {
  final String error;
  ErrorGetFavoritesState(this.error);
}

