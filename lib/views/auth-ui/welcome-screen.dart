import 'package:flutter/material.dart';
import 'package:foodie/controllers/google-sign-in-controller.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:foodie/views/auth-ui/sign-in-screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
class WelcomeScreen extends StatefulWidget {
   WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GoogleSignInController _googleSignInController=Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text('Welcome To My App',style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                height: 200,
                width: 400,
                child: Lottie.asset('assets/lotie/splashlogo1.json'),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text('Happy Shopping',
                  style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w100,fontSize: 16),),
              ),
              SizedBox(
                height: Get.height/12,
              ),
              Material(
                child: Container(
                  width: Get.width/1.2,
                  height: Get.height/12,
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondaryColor,
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: TextButton.icon(
                    icon:Image.asset('assets/icons/google.png',height: Get.height/12,width:Get.width/12,),
                    label: Text('Sign in with google',style: TextStyle(color: AppConstant.appTextColor,fontSize: 16),),
                    onPressed: () {
                      _googleSignInController.signInWithGoogle();
                    },
                  )
                ),
              ),
              SizedBox(
                height: Get.height/30,
              ),
              Material(
                child: Container(
                    width: Get.width/1.2,
                    height: Get.height/12,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: TextButton.icon(
                      icon: Icon(Icons.email,color: Colors.white,),
                      label: Text('Sign in with email',style: TextStyle(color: AppConstant.appTextColor,fontSize: 16),),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            SignInScreen()));
                      },
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
