import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodie/models/contacts-model.dart';
import 'package:foodie/views/user-panel/contacts.dart';
import 'package:foodie/views/user-panel/main_screens.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app-constant.dart';
 void sendMessage({
   required BuildContext context,
   required String customerName,
   required String customerEmail,
   required String customerSubject,
   required String customerMessage
  }){
   final FirebaseFirestore _firestore=FirebaseFirestore.instance;
   final user=FirebaseAuth.instance.currentUser;
   if(user!=null){
     //EasyLoading.show(status: "please wait..");
     ContactsModel contactsModel=ContactsModel(
       uId: user.uid,
       username: customerName,
       useremail: customerEmail,
       usersubject: customerSubject,
       userMessage: customerMessage,
       createdOn: DateTime.now(),
     );
     //add data into database firebase firestore
     _firestore
         .collection('contacts')
     .doc()
         .set(contactsModel.toMap());
     Get.snackbar(
       "Your Message Send Successfully",
       "Thank you for conatct.",
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: AppConstant.appSecondaryColor,
       colorText: AppConstant.appTextColor,
     );
     Get.to(()=>MainScreens());
   }else{
     Get.snackbar(
       "Contacts Error",
       "Message is not send pls try againg.",
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: AppConstant.appSecondaryColor,
       colorText: AppConstant.appTextColor,
     );
   }

 }