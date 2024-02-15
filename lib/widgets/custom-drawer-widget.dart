import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:foodie/views/user-panel/all-orders-screen.dart';
import 'package:foodie/views/user-panel/all-products-screen.dart';
import 'package:foodie/views/user-panel/main_screens.dart';
import 'package:foodie/views/user-panel/profile-screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/auth-ui/welcome-screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});


  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final user=FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: Get.height/25),
    child: Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
        )
      ),
      child: Wrap(
        runSpacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('~SSG~',style: TextStyle(color: AppConstant.appTextColor),),
              subtitle: Text('Version 1.0.1',style: TextStyle(color: AppConstant.appTextColor),),
              leading: CircleAvatar(
                radius: 22.0,
                backgroundColor: Colors.white,
                child: Text('S'),
              ),
            ),
          ),
          Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 1.5,
            color: Colors.white,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: ListTile(
          //     onTap: (){
          //       Get.to(()=>MainScreens());
          //     },
          //     titleAlignment: ListTileTitleAlignment.center,
          //     title: Text('Home',style: TextStyle(color: AppConstant.appTextColor),),
          //     leading: Icon(Icons.home,color: AppConstant.appTextColor,),
          //     trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: (){
                Get.to(()=>AllProductsScreen());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('Products',style: TextStyle(color: AppConstant.appTextColor),),
              leading: Icon(Icons.add_shopping_cart,color: AppConstant.appTextColor,),
              trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: (){
                Get.back();
                Get.to(()=>AllOrdersScreen());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('Orders',style: TextStyle(color: AppConstant.appTextColor),),
              leading: Icon(Icons.shopping_bag,color: AppConstant.appTextColor,),
              trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: (){
                Get.to(()=>ProfileScreen(user:user));
                //account();
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('Profile',style: TextStyle(color: AppConstant.appTextColor),),
              leading: Icon(Icons.person,color: AppConstant.appTextColor,),
              trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('Contact',style: TextStyle(color: AppConstant.appTextColor),),
              leading: Icon(Icons.help,color: AppConstant.appTextColor,),
              trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: () async {
                GoogleSignIn googleSignIn=GoogleSignIn();
                FirebaseAuth _auth=FirebaseAuth.instance;
                await _auth.signOut();
                await googleSignIn.signOut();
                Get.offAll(()=>WelcomeScreen());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('Logout',style: TextStyle(color: AppConstant.appTextColor),),
              leading: Icon(Icons.logout,color: AppConstant.appTextColor,),
              trailing: Icon(Icons.arrow_forward,color: AppConstant.appTextColor,),
            ),
          ),
        ],
      ),
      backgroundColor: AppConstant.appSecondaryColor,
    ),
    );
  }
}
