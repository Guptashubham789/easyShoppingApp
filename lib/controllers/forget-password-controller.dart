import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodie/models/user-model.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:foodie/views/auth-ui/sign-in-screen.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;


  Future<void> ForgetPasswordFunction(
      String userEmail,
      ) async{
    try{
      EasyLoading.show(status: "Please wait....");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        "Request sent successfully",
        "Password reset link sent to this - $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor,
      );
      Get.offAll(()=>SignInScreen());
      EasyLoading.dismiss();

    }on FirebaseAuthException catch(e){
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}