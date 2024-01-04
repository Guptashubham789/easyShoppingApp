import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodie/views/auth-ui/welcome-screen.dart';
import 'package:foodie/views/user-panel/main_screens.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 8), () {
      Get.to(()=>WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Lottie.asset('assets/lotie/splashlogo1.json'),
              ),
            ),Container(
              width: Get.width,
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Text(AppConstant.appPowerBy,style: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.bold),),
            )

          ],
        ),
      ),
    );
  }
}
