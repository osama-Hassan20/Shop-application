import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder: (context,state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context) =>
              ListView.separated(
          //  physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) =>buildListFavorite (ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
            separatorBuilder: (context,index) =>Container(height: .5,color: Colors.black,),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback:(context) => Center(child: CircularProgressIndicator()) ,
        );
      },

    );
  }
}
