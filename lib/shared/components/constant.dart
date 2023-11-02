//POST
//UPDATE
//DELETE

//https://newsapi.org/
// v2/top-headlines?
// country=eg&category=business&apiKey=5d9b02d51b0446f3b5095e818afbdb1e

//GET

// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=5d9b02d51b0446f3b5095e818afbdb1e


//base url : https://newsapi.org/
//method (url) : v2/everything?
//queries : q=Apple&from=2022-11-09&sortBy=popularity&apiKey=5d9b02d51b0446f3b5095e818afbdb1e



import 'package:bloc/bloc.dart';

import '../../modules/shop_login_screen/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.removeDate(key: 'token',).then((value) {
    if(value!){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token ;

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}