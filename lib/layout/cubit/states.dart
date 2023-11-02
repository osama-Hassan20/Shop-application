
import '../../models/change_favorites_model.dart';
import '../../models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNaveState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{
  late final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{
  late final String error;
  ShopErrorCategoriesDataState(this.error);
}

class ShopChangeFavoritesDataState extends ShopStates{}

class ShopSuccessChangeFavoritesDataState extends ShopStates
{
   final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesDataState(this.model);
}

class ShopErrorChangeFavoritesDataState extends ShopStates{
  late final String error;
  ShopErrorChangeFavoritesDataState(this.error);
}



class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{
  late final String error;
  ShopErrorGetFavoritesState(this.error);
}



class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{
  late final String error;
  ShopErrorUserDataState(this.error);
}


class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates
{
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates{
  late final String error;
  ShopErrorUpdateUserState(this.error);
}

