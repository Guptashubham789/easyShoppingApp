import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/controllers/get-user-data-controller.dart';
import 'package:foodie/controllers/sign-in-controller.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:foodie/views/auth-ui/forget-password-screen.dart';
import 'package:foodie/views/auth-ui/sign-up-screen.dart';
import 'package:foodie/views/user-panel/main_screens.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../admin-panel/admin-main-screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final SignInController signInController=Get.put(SignInController());
    final GetUserDataController getUserDataController=Get.put(GetUserDataController());
    TextEditingController userEmail=TextEditingController();
    TextEditingController userPassword=TextEditingController();
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
                    controller: userEmail,
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
                  child: Obx(()=>TextFormField(
                    controller: userPassword,
                    obscureText: signInController.isPasswordVisible.value,
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            signInController.isPasswordVisible.toggle();
                          },
                          child:signInController.isPasswordVisible.value? Icon(Icons.visibility_off):Icon(Icons.visibility),
                        ),
                        contentPadding: EdgeInsets.only(top: 2,left: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>ForgetPasswordScreen());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerRight,
                  child: Text("Forget Password?",
                  style: TextStyle(
                    color: AppConstant.appSecondaryColor,
                    fontWeight: FontWeight.bold
                  ),),
                ),
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
                      onPressed: () async{
                        String email=userEmail.text.trim();
                        String password=userPassword.text.trim();
                        if(email.isEmpty || password.isEmpty){
                          Get.snackbar(
                            "Error",
                            "Please enter email and password..",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecondaryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }else{
                          UserCredential? userCredential=await signInController.signInFunction(
                              email,
                              password
                          );


                          var userData=await getUserDataController
                              .getUserData(userCredential!.user!.uid);

                          if(userCredential!=null){
                            if(userCredential.user!.emailVerified){
                              if(userData[0]['isAdmin']==true){
                                  Get.snackbar(
                                    "Success Admin Login",
                                    "Login Successfully!",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppConstant.appSecondaryColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                  Get.offAll(()=>AdminMainScreen());
                              }else{
                                Get.snackbar(
                                  "Success User Login",
                                  "Login Successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appSecondaryColor,
                                  colorText: AppConstant.appTextColor,
                                );
                                Get.offAll(()=>MainScreens());
                              }

                              Get.offAll(()=>MainScreens());
                            }else{
                              Get.snackbar(
                                "Error",
                                "Please verify your email before login..",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondaryColor,
                                colorText: AppConstant.appTextColor,
                              );
                            }
                          }else{
                            Get.snackbar(
                              "Error",
                              "Please try again...",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondaryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        //     SignInScreen()));
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
