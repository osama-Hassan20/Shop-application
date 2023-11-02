
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'enter text to search';
                        }else{
                          return null;
                        }
                      },
                      onSubmit: (text){
                          SearchCubit.get(context).search(text);
                      },
                        label: 'Search',
                        prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(state is SearchLoadingState)
                      RefreshProgressIndicator(),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        //  physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index) =>buildListFavorite(SearchCubit.get(context).model!.data!.data![index] , context , isOldPrice: false),
                        separatorBuilder: (context,index) =>Container(height: .5,color: Colors.black,),
                        itemCount:SearchCubit.get(context).model!.data!.data!.length!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}