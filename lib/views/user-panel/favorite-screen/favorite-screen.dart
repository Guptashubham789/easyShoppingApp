import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/favorite-model.dart';

import '../../../utils/app-constant.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    //final wid=FirebaseFirestore.instance.collection('favorite').get();
   // print(wid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Wishlist',style: TextStyle(color: AppConstant.appTextColor),),

      ),
      body:Column(
        children: [],
      )
    );
  }
}
