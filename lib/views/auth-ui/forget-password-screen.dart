import 'package:flutter/material.dart';
import 'package:foodie/controllers/forget-password-controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/sign-in-controller.dart';
import '../../utils/app-constant.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final ForgetPasswordController forgetPasswordController=Get.put(ForgetPasswordController());
    TextEditingController userEmail=TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text("Forget Screen",style: TextStyle(color: Colors.white),),
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

              SizedBox(
                height: Get.height/30,
              ),
              Material(
                child: Container(
                    width: Get.width/1.5,
                    height: Get.height/16,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: TextButton.icon(
                      icon: Icon(Icons.lock_reset_outlined,color: Colors.white,),
                      label: Text('Forgot Password',style: TextStyle(color: AppConstant.appTextColor,fontSize: 16),),
                      onPressed: () async{
                        String email=userEmail.text.trim();
                        if(email.isEmpty){
                          Get.snackbar(
                            "Error",
                            "Please enter the email..",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecondaryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }else{
                          String email=userEmail.text.trim();
                          forgetPasswordController.ForgetPasswordFunction(email);
                        }
                      },
                    )
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
