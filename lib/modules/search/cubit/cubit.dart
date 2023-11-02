import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/modules/search/cubit/states.dart';

import '../../../../shared/network/end_point.dart';
import '../../../models/search_model.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text' : text,
      },
    ).then((value) {
      model=SearchModel.fromJson(value!.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}