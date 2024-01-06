import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/controllers/sign-up-controller.dart';
import 'package:foodie/views/auth-ui/sign-in-screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app-constant.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController=Get.put(SignUpController());
  TextEditingController userName=TextEditingController();
  TextEditingController userEmail=TextEditingController();
  TextEditingController userPhone=TextEditingController();
  TextEditingController userCity=TextEditingController();
  TextEditingController userPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,

        title: Text("SignUp Screen",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height/30,
              ),
             Text("Welcome to my app",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppConstant.appSecondaryColor),),
              SizedBox(
                height: Get.height/30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userName,
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person),
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
                  child: Obx(()=> TextFormField(
                    controller: userPassword,
                    obscureText: signUpController.isPasswordVisible.value,
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Password ",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            signUpController.isPasswordVisible.toggle();
                          },
                            child:signUpController.isPasswordVisible.value? Icon(Icons.visibility_off):Icon(Icons.visibility),
                        ),
                        contentPadding: EdgeInsets.only(top: 2,left: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userPhone,
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Phone",
                        prefixIcon: Icon(Icons.call),
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
                    controller: userCity,
                    cursorColor: AppConstant.appSecondaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "City",
                        prefixIcon: Icon(Icons.location_pin),
                        contentPadding: EdgeInsets.only(top: 2,left: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
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
                      icon: Icon(Icons.app_registration,color: Colors.white,),
                      label: Text('SignUp',style: TextStyle(color: AppConstant.appTextColor,fontSize: 16),),
                      onPressed: () async{
                          String name=userName.text.trim();
                          String email=userEmail.text.trim();
                          String phone=userPhone.text.trim();
                          String city=userCity.text.trim();
                          String password=userPassword.text.trim();
                          String userDeviceToken='';
                          if(name.isEmpty || email.isEmpty || phone.isEmpty || city.isEmpty || password.isEmpty){
                            Get.snackbar(
                                "Error",
                                "Please enter all detatils",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondaryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }else{
                            //user hmara empty ho bhi sakta hai aur nhi bhi ho sakta hai
                            UserCredential? userCredential=await signUpController.signUpFunction(
                                name,
                                email,
                                phone,
                                city,
                                password,
                                userDeviceToken
                            );
                            if(userCredential != null){
                              Get.snackbar(
                                "Verification email sent",
                                "Please check your email..",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondaryColor,
                                colorText: AppConstant.appTextColor,
                              );
                              FirebaseAuth.instance.signOut();
                              Get.offAll(()=>SignInScreen());
                            }
                          }
                      },
                    )
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(color: AppConstant.appSecondaryColor,fontSize: 14)),
                  GestureDetector(onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        SignInScreen()));
                  },child: Text("Login",style: TextStyle(color: AppConstant.appSecondaryColor,fontSize: 14,fontWeight: FontWeight.bold))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
