import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<String> getCustomerDeviceToken() async{
  try{
    String? token =await FirebaseMessaging.instance.getToken();
    if(token != null){
      return token;
    }else{
      throw Exception("Error");
    }
  }catch (e){
    print("Error $e");
    throw Exception("Error");
  }
}