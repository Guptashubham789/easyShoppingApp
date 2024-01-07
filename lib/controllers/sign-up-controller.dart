import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodie/controllers/get-device-token-controller.dart';
import 'package:foodie/models/user-model.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //for password visibility
  var isPasswordVisible=false.obs;

  Future<UserCredential?> signUpFunction(
      String userName,
      String userEmail,
      String userPhone,
      String userCity,
      String userPassword,
      String userDeviceToken,
      ) async{
      try{
        EasyLoading.show(status: "Please wait....");
        UserCredential userCredential=await _auth.createUserWithEmailAndPassword(
            email: userEmail,
            password: userPassword
        );
        //send email verification
        await userCredential.user!.sendEmailVerification();

        UserModel userModel=UserModel(
            uId: userCredential.user!.uid, //user! means user mil gaya hai to user hmara null nhi ho sakta
            username: userName,
            useremail: userEmail,
            userphone: userPhone,
            userImg: '',
            userDeviceToken: userDeviceToken,
            usercountry: '',
            userAddress: '',
            userStreet: '',
            isActive: true,
            isAdmin: false,
            createdOn: DateTime.now(),
            userCity: userCity,
        );

        //add data into database firebase firestore
        _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toMap());
        EasyLoading.dismiss();
        return userCredential;
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