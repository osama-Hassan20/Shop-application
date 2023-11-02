import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/cubit/cubit.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../styles/colors.dart';

//******************************************************************************
Widget defaultButton ({
   double width = double.infinity ,
   Color background = Colors.blue,
  bool isUpperCase = true,
  required VoidCallback function,
  required String text,

}) =>
Container(

  width: width,

  child: MaterialButton(
    onPressed: function ,
    child: Text(
      isUpperCase ? text.toUpperCase(): text,
    style: TextStyle(
      color: Colors.white,
),
),
),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: background,
  ),
) ;
//******************************************************************************


//******************************************************************************
Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
})=>TextButton(
  onPressed: function,
  child: Text(text.toUpperCase()),
);
//******************************************************************************


//******************************************************************************
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  bool isPassword = false ,
  ValueChanged? onChanged,
  GestureTapCallback? onTap,
  FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
TextFormField(
controller: controller,
keyboardType: type,
obscureText: isPassword,
onFieldSubmitted:onSubmit,
onChanged: onChanged,
validator:validate,
onTap: onTap,
enabled: isClickable,
decoration: InputDecoration(
labelText: label,

prefixIcon: Icon(
    prefix,
),
  suffixIcon: suffix !=null ? IconButton(
    onPressed:  suffixPressed,

    icon: Icon(
      suffix,
    ),
  ) :null,
border: OutlineInputBorder() ,
),
);
//******************************************************************************


//******************************************************************************
void navigateTo(context ,widget ) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget ,
  ),
);
//******************************************************************************


//******************************************************************************
void navigateAndFinish(context ,widget ) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget ,
  ),
  (route) {
    return false;
  },
);
//******************************************************************************


//******************************************************************************
void ShowToast({
  required String text,
  required ToastState state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState {SUCCESS , ERROR , WORNING , SOON}

Color? chooseToastColor (ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WORNING:
      color = Colors.amber;
      break;
    case ToastState.SOON:
      color = Colors.grey;
      break;
  }
  return color;
}


void comingSoon(){
  ShowToast(text: 'Coming Soon', state: ToastState.SOON);
}
//******************************************************************************


//******************************************************************************
Widget buildListFavorite (model,context , {bool isOldPrice =true})=>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            SizedBox(
              width: 120,
              height: 120,

              child: CachedNetworkImage(
                imageUrl: "${model!.image}",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>  Image(
                  image: NetworkImage('https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',),fit: BoxFit.fill,),
              ),
            ),

            if(model!.discount != 0  && isOldPrice)
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
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.3
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model!.price.toString()}',
                    style: TextStyle(
                        fontSize: 12,
                        color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model!.discount != 0 && isOldPrice)
                    Text(
                      '${model!.oldPrice.toString()}',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  Spacer(),
                  IconButton(

                    onPressed: (){
                      ShopCubit.get(context).changeFavorites(model!.id);

                    },
                    icon: Icon(
                      //Icons.favorite_border,
                      ShopCubit.get(context).favorites[model!.id]! ? Icons.favorite : Icons.favorite_border,
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
  ),
);

//******************************************************************************


//******************************************************************************

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  FullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // لتحديد خلفية سوداء للشاشة الكاملة
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // لاغلاق الشاشة الكاملة عند النقر
        },
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: 'imageHero', // تعيين علامة لـ Hero لإظهار الصورة كاملة الشاشة بشكل سلس عند النقر
                child: Image.network(imagePath), // استخدام الصورة من الشبكة كمثال، يمكنك استبدالها بمسار محلي إذا لزم الأمر
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//******************************************************************************


