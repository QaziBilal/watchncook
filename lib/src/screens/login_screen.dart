
import 'package:flutter/material.dart';
import 'package:watchncook/src/firebase/google_auth_services.dart';
import 'package:watchncook/src/helper/sizedbox_extenstion.dart';
import 'package:watchncook/src/widgets/custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(

        children: [
          SizedBox(height: sh * 0.1,),
          Image.asset("assets/images/authentication.png",height: sh * 0.2,width: sw * 0.8,),
          40.height,
          Padding(
  padding: const EdgeInsets.only(left: 40, right: 40),
  child: 
      ElevatedButton(
        onPressed: () async {
          AuthServices().signInwithGoogle();
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Image.asset("assets/images/google.png", width: sh * 0.06, height: sw * 0.06),
                SizedBox(width: 20),
                customText(context, "Login with Google", size: 20, color: Colors.black),
              ],
            ),
          ),
        ),
      ),)]),);

  }     
}