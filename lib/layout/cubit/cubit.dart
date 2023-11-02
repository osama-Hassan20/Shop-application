import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/states.dart';
import 'package:shop_application/modules/search/search_screen.dart';

import '../../models/categories_model.dart';
import '../../models/change_favorites_model.dart';
import '../../models/favorites_model.dart';
import '../../models/home_model.dart';
import '../../models/login_model.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/settings/setting_screen.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/end_point.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super (ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreens =
  [
    HomeScreen(),
    SearchScreen(),
    // CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNaveState());
  }

  HomeModel? homeModel;

  Map<int,bool> favorites = {};
  void getHomeData ()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      // printFullText(homeModel!.data!.toString());
      print(homeModel?.status);
      
      for (var element in homeModel!.data!.products!) {
        favorites.addAll({
          element.id:element.inFavorites
        });
      }
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      emit(ShopErrorHomeDataState(error.toString()));
      printFullText(error.toString());
    });
  }


  CategoriesModel? categoriesModel;
  void getCategoriesData()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel?.fromJson(value?.data);

      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){
      emit(ShopErrorCategoriesDataState(error.toString()));
      printFullText(error.toString());
    });
  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesDataState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id' :productId,
      },
     token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel?.fromJson(value?.data);
      print(value?.data);
      if(changeFavoritesModel!.status == false){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesDataState(changeFavoritesModel! ));
    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesDataState(error.toString()));
      printFullText(error.toString());
    });
  }


  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel?.fromJson(value?.data);
      printFullText(value!.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      emit(ShopErrorGetFavoritesState(error.toString()));
      printFullText(error.toString());
    });
  }


  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel?.fromJson(value?.data);
      printFullText(userModel!.data!.name!);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error){
      emit(ShopErrorUserDataState(error.toString()));
      printFullText(error.toString());
    });
  }


  void updateUserData({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      userModel = ShopLoginModel?.fromJson(value?.data);
      printFullText(userModel!.data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error){
      emit(ShopErrorUpdateUserState(error.toString()));
      printFullText(error.toString());
    });
  }


}