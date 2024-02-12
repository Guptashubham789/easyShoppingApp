import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/services/genrate-oerder-id.dart';
void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerLandmark,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken}) async{

  final user=FirebaseAuth.instance.currentUser;
  if(user!=null){
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
      }
    }catch (e){
      print("Error : $e");
    }
  }


}