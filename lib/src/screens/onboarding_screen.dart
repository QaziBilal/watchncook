import 'package:flutter/material.dart';
import 'package:watchncook/src/firebase/app_update.dart';
import 'package:watchncook/src/firebase/google_auth_services.dart';
import 'package:watchncook/src/helper/sizedbox_extenstion.dart';
import 'package:watchncook/src/screens/main_screen.dart';
import 'package:watchncook/src/widgets/custom_text.dart';

import '../helper/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  List images = [
    "assets/images/splash1.png",
    "assets/images/splash2.png",
    "assets/images/splash3.png",
  ];

  @override
  void initState() {
    super.initState();
    FirebaseWork().checkForUpdates(context);
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: images.length,
            onPageChanged: onChanged,
            itemBuilder: (context, index) {
              return Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    top: sh * 0.1,
                    left: sw * 0.1,
                    child: Column(
                      children: [
                        customText(context, "Welcome", size: 30),
                        SizedBox(
                          height: sh * 0.05,
                          width: sw * 0.8,
                          child: Center(
                              child: customText(context, "to Watch n Cook",
                                  size: 25)),
                        )
                      ],
                    )),
                Positioned(
                    top: sh * 0.55,
                    left: sw * 0.1,
                    child: Column(
                      children: [
                        customText(context, "Get Inspired", size: 23),
                        8.height,
                        SizedBox(
                          height: sh * 0.1,
                          width: sw * 0.8,
                          child: Center(
                            child: customText(context,
                                "Discover delicious recipes \n and stunning food recipes",
                                size: 23),
                          ),
                        ),
                      ],
                    ))
              ]);
            },
          ),
          Positioned(
              top: sh * 0.76,
              left: sw * 0.42,
              child: Row(
                children: List<Widget>.generate(3, (index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: index == currentPage
                            ? AppColors.mainColor
                            : Color.fromARGB(255, 165, 165, 165),
                      ),
                    ),
                  );
                }),
              )),
          Positioned(
              bottom: sh * 0.1,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      },
                      child: Container(
                        height: sh * 0.06,
                        width: sw * 0.35,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: customText(context, "START", size: 24)),
                      ),
                    ),
                    SizedBox(
                      width: sw * 0.1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Widget destinationScreen = await AuthServices().handleAuthState();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> destinationScreen));
                      },
                      child: Container(
                        height: sh * 0.06,
                        width: sw * 0.35,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: customText(context, "LOGIN", size: 24)),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
