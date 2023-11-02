
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {
        if(state is ShopSuccessChangeFavoritesDataState)
        {
          if(state.model.status == false)
          {
            ShowToast(
                text: state.model.message!,
                state: ToastState.ERROR,
            );
          }
        }
      },
      builder: (context , state)
      {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&  ShopCubit.get(context).categoriesModel != null,
            builder: (context) =>ProductBuilder(ShopCubit.get(context).homeModel! , ShopCubit.get(context).categoriesModel!,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget ProductBuilder(HomeModel model ,CategoriesModel categoriesModel ,context) =>
      SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model.data!.banners!.map((e) => Image(
              image:NetworkImage('${e.image}') ,
              width: double.infinity,
              fit: BoxFit.cover ,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
            )),

        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index) =>buildCategoryItem(categoriesModel!.data!.data![index]),
                    separatorBuilder: (context , index) => SizedBox(width: 10,),
                    itemCount: categoriesModel.data!.data!.length,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),

        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio:1/2 ,
            children: List.generate(
                model.data!.products!.length,
                    (index) =>buildGridProduct(model.data!.products![index],context) ,
          ),
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox(
            height: 100,
            width: 100,

            child: CachedNetworkImage(
              imageUrl: "${model.image}",
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>  Image(
                image: NetworkImage('https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',),fit: BoxFit.fill,),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(.7),
            width: 100,
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );

  Widget buildGridProduct(ProductModel model,context) =>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,

              child: CachedNetworkImage(
                imageUrl: "${model.image}",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>  Image(
                  image: NetworkImage('https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',),fit: BoxFit.fill,),
              ),
            ),
            if(model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                        fontSize: 12,
                      color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                    ),
                  ),
                  Spacer(),
                  IconButton(

                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                      icon: Icon(
                        ShopCubit.get(context).favorites[model.id]! ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,

                        size: 30,
                      ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
