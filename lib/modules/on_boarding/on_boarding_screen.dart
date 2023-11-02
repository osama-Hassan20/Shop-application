import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../shop_login_screen/shop_login_screen.dart';
//Color(0xFFfafafa),
class BoardingModel{
   late final String image;
   late final String title;
   late final String body;

   BoardingModel({
   required this.image,
   required this.title,
   required this.body,
});
}
class OnBoardingScreen extends StatefulWidget
{

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding =[
    BoardingModel(
        image: 'assets/images/onboard_2.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'
    ),
    BoardingModel(
        image: 'assets/images/onboard_2.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'
    ),
    BoardingModel(
        image: 'assets/images/onboard_2.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'
    ),


  ];
  bool isLast = false;

  void submit(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value)
    {
      if(value!){

          navigateAndFinish(context, ShopLoginScreen());


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function:submit,
              text: 'skip')

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30) ,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller:  boardController ,
                onPageChanged: (int index){
                  if(index == boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
                  itemCount:boarding.length ,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 15,
                    expansionFactor: 3,
                    dotWidth: 20,
                    spacing: 6

                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: ()
                    {
                      if(isLast){
                        submit();
                      //  navigateAndFinish(context, ShopLoginScreen());;
                      }else{
                        boardController.nextPage(
                            duration: Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.decelerate);
                      }
                      // boardController.nextPage(
                      //     duration: Duration(
                      //       milliseconds: 750
                      //     ),
                      //     curve: Curves.decelerate);
                    },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),

          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.body}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
