import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:foodie/views/auth-ui/welcome-screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text("Dashboard",style: TextStyle(color: AppConstant.appTextColor),),
        actions: [
          IconButton(
              onPressed: () async{
                GoogleSignIn googleSignIn=GoogleSignIn();
                await googleSignIn.signOut();
                Get.offAll(()=>WelcomeScreen());
                //FirebaseAuth.instance.signOut();
              }, icon: Icon(Icons.logout,color: Colors.white70,)),
        ],
      ),
      body: Center(
        child: Text("Main Screen User panel"),
      ),
    );
  }
}
