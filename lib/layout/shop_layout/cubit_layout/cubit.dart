import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/shop_layout/cubit_layout/states.dart';
import 'package:shop_application/model/categories_model.dart';
import 'package:shop_application/model/favorites_model.dart';
import 'package:shop_application/model/get_favorites_model.dart';
import 'package:shop_application/model/home_model.dart';
import 'package:shop_application/model/search_model.dart';
import 'package:shop_application/module/categories/categories_screen.dart';
import 'package:shop_application/module/favorites/favorites_screen.dart';
import 'package:shop_application/module/home/home_screen.dart';
import 'package:shop_application/module/settings/settings_screen.dart';
import 'package:shop_application/shared/network/remote/dio_helper.dart';

import '../../../model/profile_model.dart';
import '../../../model/update_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_point.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(InitialShopLayoutState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];
  int currentIndex = 0;

  void changeBottomNavigator(index) {
    currentIndex = index;
    emit(ChangeBottomNavigatorState());
  }


  Map<int,bool> favorites = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingGetHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id! : element.inFavorites!
        });
      });
      print(favorites);
      emit(SuccessGetHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetHomeState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void favoritesMethod(int id) {
    favorites[id] = !favorites[id]!;
    emit(LoadingFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id' : id,
      },
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(SuccessFavoritesState(favoritesModel!));
      getFavorites();
    }).catchError((error) {
      print(error.toString());
      favorites[id] = !favorites[id]!;
      emit(ErrorFavoritesState(error.toString()));
    });
  }


  GetFavoritesModel? getFavoritesModel;
  void getFavorites() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(SuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavoritesState(error.toString()));
    });
  }


  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(LoadingGetCategoriesState());
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessGetCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetCategoriesState(error.toString()));
    });
  }


  SearchModel? searchModel;
  void getSearch(String value) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text' : value,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchState(error.toString()));
    });
  }

  ProfileModel? profileModel;
  void getProfile() {
    emit(LoadingGetProfileState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(SuccessGetProfileState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetProfileState(error.toString()));
    });
  }

  UpdateProfileModel? updateProfileModel;
  void updateProfile({
  required String name,
    required String email,
    required String phone,
}) {
    emit(LoadingUpdateProfileState());
    DioHelper.putData(
      url: UPDATE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      emit(SuccessUpdateProfileState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateProfileState(error.toString()));
    });
  }

}
