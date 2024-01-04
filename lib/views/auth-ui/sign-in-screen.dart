import 'package:flutter/material.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:foodie/views/auth-ui/sign-up-screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,

        title: Text("Login Screen",style: TextStyle(color: Colors.white),),
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
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.only(top: 2,left: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                        contentPadding: EdgeInsets.only(top: 2,left: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerRight,
                child: Text("Forget Password?",
                style: TextStyle(
                  color: AppConstant.appSecondaryColor,
                  fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(
                height: Get.height/30,
              ),
              Material(
                child: Container(
                    width: Get.width/2,
                    height: Get.height/16,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: TextButton.icon(
                      icon: Icon(Icons.login,color: Colors.white,),
                      label: Text('Login',style: TextStyle(color: AppConstant.appTextColor,fontSize: 16),),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            SignInScreen()));
                      },
                    )
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(color: AppConstant.appSecondaryColor,fontSize: 14)),
                  GestureDetector(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        SignUpScreen()));
                  },
                      child: Text("SignUp",style: TextStyle(color: AppConstant.appSecondaryColor,fontSize: 14,fontWeight: FontWeight.bold))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
