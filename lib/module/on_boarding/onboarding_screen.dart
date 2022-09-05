import 'package:flutter/material.dart';
import 'package:shop_application/module/login/login_screen.dart';
import 'package:shop_application/shared/components/components.dart';
import 'package:shop_application/shared/components/constants.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemPageView {
  final String image;
  final String textTitle;
  final String textBody;

  ItemPageView(
      {required this.image, required this.textTitle, required this.textBody});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<ItemPageView> onBoarding = [
    ItemPageView(
      image: 'assets/image/onboardingone.jpg',
      textTitle: 'Welcome In Our E-Commerence',
      textBody: 'Sign Up To Have On Our Sales',
    ),
    ItemPageView(
      image: 'assets/image/onboardingtwo.jpg',
      textTitle: 'Welcome In Our E-Commerence',
      textBody: 'Sign Up To Have On Our Sales',
    ),
    ItemPageView(
      image: 'assets/image/onboardingthree.jpg',
      textTitle: 'Welcome In Our E-Commerence',
      textBody: 'Sign Up To Have On Our Sales',
    ),
  ];

  var pageController = PageController();

  bool isLast = false;

  void submit(context) {
    CacheHelper.setData(key: 'onBoarding', value: true).then((value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit(context);
            },
            child: const Text(
              'SKIP',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (onBoarding.length - 1 == index) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildPageView(onBoarding[index]),
                itemCount: onBoarding.length,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    activeDotColor: defaultColor,
                    spacing: 4.0,
                    expansionFactor: 4.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit(context);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageView(ItemPageView item) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                item.image,
              ),
            ),
          ),
          Text(
            item.textTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            item.textBody,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ],
      );
}
