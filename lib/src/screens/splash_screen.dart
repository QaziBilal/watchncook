import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:watchncook/src/helper/constants.dart';
import 'package:watchncook/src/screens/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;

    return AnimatedSplashScreen(
      splashIconSize: double.infinity,
      duration: 2000,
      splash: Container(
        height: sh,
        width: sw,
        decoration: BoxDecoration(color: AppColors.mainColor.withOpacity(0.2)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 151,
              width: 124,
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
          ),
        ),
      ),
      nextScreen: const OnboardingScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
