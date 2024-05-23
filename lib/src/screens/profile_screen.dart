import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchncook/src/firebase/google_auth_services.dart';
import 'package:watchncook/src/helper/constants.dart';
import 'package:watchncook/src/helper/sizedbox_extenstion.dart';
import 'package:watchncook/src/screens/login_screen.dart';

import '../widgets/custom_text.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  bool userLogin = FirebaseAuth.instance.currentUser != null ? true : false;

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: customText(context, "Profile",
              size: 20, fontWeight: FontWeight.w800)),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: userLogin == true
                ? userLoggedin(context, sh)
                : userLoggetOut(context, sh, sw)
            // child:  userLoggedin(context, sh),
            ),
      ),
    );
  }
}

Widget userLoggetOut(context, sh, sw) {
  return Column(
    children: [
      Image.asset(
        AppImages.easyFriedRice,
        width: sw * 0.8,
        height: sh * 0.5,
      ),
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: Container(
          height: 40,
          width: sw * 0.8,
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: customText(context, "Login Here!",
                size: 20, color: AppColors.white),
          ),
        ),
      ),
      20.height,
      ListTile(
        leading: const Icon(Icons.share),
        title: customText(context, "Share", color: Colors.black, size: 18),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.star_rate),
        title: customText(context, "Rate Us", color: Colors.black, size: 18),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.apps),
        title: customText(context, "Other Apps", color: Colors.black, size: 18),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.security),
        title: customText(context, "Privacy and Policy",
            color: Colors.black, size: 18),
      ),
      30.height
    ],
  );
}

Widget userLoggedin(context, sh) {
  return Column(
    children: [
      CircleAvatar(
        radius: sh * 0.07,
        backgroundImage: NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL.toString()),
      ),
      20.height,
      customText(context, "${FirebaseAuth.instance.currentUser!.displayName}",
          color: AppColors.mainColor, size: 30),
      20.height,
      ListTile(
        leading: const Icon(Icons.share),
        title: customText(context, "Share", color: Colors.black, size: 18),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.star_rate),
        title: customText(context, "Rate Us", color: Colors.black, size: 18),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.apps),
        title: customText(context, "Other Apps", color: Colors.black, size: 18),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.security),
        title: customText(context, "Privacy and Policy",
            color: Colors.black, size: 18),
      ),
      const Divider(),
      ListTile(
        onTap: () {
          AuthServices().signOut();
        },
        leading: const Icon(Icons.logout),
        title: customText(context, "Logout", color: Colors.black, size: 18),
      ),
    ],
  );
}

Widget noti(sh, sw, context) {
  return Container(
    width: sw * 0.9,
    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF4F4F4)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customText(context,
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod.",
            textAlign: TextAlign.justify, color: AppColors.black, size: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(context, "14 Jun, 2022",
                color: AppColors.black, size: 12),
            customText(context, "08:30 Pm", color: AppColors.black, size: 12),
          ],
        )
      ],
    ),
  );
}
