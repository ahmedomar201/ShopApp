import 'package:flutter/material.dart';
import 'package:marketapp/network/local/cash_helper.dart';
import 'package:marketapp/login/shop_login.dart';
import 'package:marketapp/tasks.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'colors.dart';

class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}
// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
  var boardController=PageController();

  List<BoardingModel>boarding=
  [
    BoardingModel(
        title: 'On Board 1 Title',
        image: 'assets/images/father-son.jpg',
        body:'On Board 1 Body' ),
    BoardingModel(
        title: 'On Board 2 Title',
        image: 'assets/images/father-son.jpg',
        body:'On Board 2 Body' ),
    BoardingModel(
        title: 'On Board 3 Title',
        image: 'assets/images/father-son.jpg',
        body:'On Board 3 Body' ),

  ];
  bool isLast=false;

  void submit()
  {
    CacheHelper.saveData(key: 'OnBoarding', value: true).
    then((value)
    {
      if(value)
      {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });

  }

  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:submit,
              child: Text('SKIP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),))
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                onPageChanged: (int index)
                {
                  if(index==boarding.length-1)
                  {
                    setState(()
                    {
                      isLast=true;
                    });
                    //print("last");
                  }else
                  {
                   //print("not last");
                    setState(()
                    {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor:defaultColor ,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                  {
                    submit();
                  }else
                  {
                    boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                child: Icon(
                  Icons.arrow_forward_ios

                ),),
              ],
            )
          ],
        ),
      ),
    );

  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage("${model.image}"),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text("${model.title}",
        style:TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),),
      SizedBox(
        height: 15,
      ),
      Text("${model.body}",
        style:TextStyle(
          fontSize: 14,
            fontWeight: FontWeight.bold
        ),),


    ],
  );
}
