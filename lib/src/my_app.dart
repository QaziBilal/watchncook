import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchncook/src/controller/tag_controller.dart';
import 'package:watchncook/src/screens/splash_screen.dart';

import 'helper/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TagController())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
            useMaterial3: true,
            textTheme: TextTheme()),
        home: SplashScreen(),
      ),
    );
  }
}
