import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodie/models/order-model.dart';
import 'package:foodie/services/genrate-oerder-id.dart';
import 'package:foodie/views/user-panel/cart-screen/cart-screen.dart';
import 'package:foodie/views/user-panel/main_screens.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../utils/app-constant.dart';
void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerLandmark,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken}) async{

  final user=FirebaseAuth.instance.currentUser;
  if(user!=null){
    EasyLoading.show(status: "please wait..");
    try{
      //data ko fetch karne ke liye hum yah query lgate hai
      QuerySnapshot querySnapshot=await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();
      //order place
      //jitne bhi doc hai usko hum list ke ander store kar lenge
      List<QueryDocumentSnapshot> documents=querySnapshot.docs;
      //one by one product ko hum for loop ke throgh
      for(var doc in documents){
        Map<String,dynamic>? data=doc.data() as Map<String,dynamic>;

        String orderId=genrateOrderId();
        //final data=snapshot.data!.docs[index];
        OrderModel cartModel=OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages:data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt:data['updatedAt'],
          productQuantity:data['productQuantity'],
          productTotalPrice:data['productTotalPrice'],
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
          customerlandmark: customerLandmark,
        );
        //mtlb ki document jitne order rhenge usko one by one fetch karega and ek new collection bnaya order name ka
        for(var x=0; x<documents.length;x++){
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set({
            'uid':user.uid,
            'customerName':customerName,
            'customerPhone':customerPhone,
            'customerLandmark':customerLandmark,
            'customerAddress':customerAddress,
            'customerDeviceToken':customerDeviceToken,
            'orderStatus':false,
            'createdAt':DateTime.now(),
          },);
          //upload order phir se order ke ander collection bnayenge
          await FirebaseFirestore.instance
          .collection('orders')
          .doc(user.uid)
          .collection('confirmOrders')
          .doc(orderId)
          .set(
            cartModel.toMap()
          );
          
          //delete cart product
          
          await FirebaseFirestore.instance.collection('cart')
          .doc(user.uid).collection('cartOrders').doc(cartModel.productId.toString()).delete().then((value)
          {
            // Get.snackbar(
            //   "Delete",
            //   "Delete cart product ${cartModel.productName.toString()}",
            //   snackPosition: SnackPosition.TOP,
            //   backgroundColor: AppConstant.appSecondaryColor,
            //   colorText: AppConstant.appTextColor,
            // );
          });
          
        }
      }
      Get.snackbar(
        "Orders Confirmed",
        "Your order is confirm \n Thank you for your Order..",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstant.appSecondaryColor,
        duration: Duration(seconds: 5),
        colorText: AppConstant.appTextColor,
      );
      EasyLoading.dismiss();
      Get.offAll(()=>MainScreens());
    }catch (e){
      print("Error : $e");
    }
  }


}