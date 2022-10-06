// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopping/models/BoardingModel.dart';
import 'package:shopping/modules/login/login_screen.dart';
import 'package:shopping/shared/components/components.dart';
import 'package:shopping/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

var boardController = PageController();

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'House Ware',
        body: 'Every Thing Exist!',
        image:
            'images/A1.jpg'),
    BoardingModel(
        title: 'House Ware',
        body: 'Online Ok!',
        image: 'images/A2.jpg'),
    BoardingModel(
        title: 'House Ware',
        body: 'Cash Back!',
        image: 'images/A3.jpg'),
  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('SKIP',style: TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    boardingBuilder(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SmoothPageIndicator(
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.deepOrange,
                dotHeight: 4.0,
                dotWidth: 8.0,
                expansionFactor: 4,
              ),
              controller: boardController,
              count: boarding.length,
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          microseconds: 850,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boardingBuilder(BoardingModel model) => Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(

            child: Image(image: AssetImage(model.image), fit: BoxFit.fill,),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          ),
          const SizedBox(
            height: 100.0,
          ),
        ],
      );

  void submit(){
    CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

}
