import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/user-model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/app-constant.dart';
class ProfileScreen extends StatefulWidget {
  String user;
   ProfileScreen( {super.key,required String this.user});
 
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Profile',style: TextStyle(color: AppConstant.appTextColor),),

      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    StreamBuilder(
                        stream :FirebaseFirestore.instance
                            .collection('users')
                        .where('uId',isEqualTo: widget.user)
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          //agr koi error hai hmare snapshot me to yh condition chale
                          if(snapshot.hasError){
                            return Center(
                              child: Text('Error'),
                            );
                          }
                          //agr waiting me h to kya return kro
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Container(
                              height: Get.height/5.5,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            );
                          }
                          // yani ki jo hum document ko fetch karna chah rhe h kya vh empty to nhi hai agr empty hai to yha par hum simple return karvayenge
                          if(snapshot.data!.docs.isEmpty){
                            return Center(
                              child: Text('No favorite product found!!'),
                            );
                          }
                          //
                          if(snapshot.data!=null){
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context,index){
                                  //yha par ek var par product ke data kka snapshot nikal lenge jisse hum id ke through data ko product model me gate kar sakte hai
                                  final productsData=snapshot.data!.docs[index];
                                  UserModel userModel=UserModel(
                                    uId:productsData['uId'], //user! means user mil gaya hai to user hmara null nhi ho sakta
                                    username:  productsData['username'],
                                    useremail:  productsData['useremail'],
                                    userphone:  productsData['userphone'],
                                    userImg:  productsData['userImg'],
                                    userDeviceToken:  productsData['userDeviceToken'],
                                    usercountry:  productsData['usercountry'],
                                    userAddress:  '',
                                    userStreet: '',
                                    isActive: true,
                                    isAdmin: false,
                                    createdOn: DateTime.now(),
                                    userCity:  productsData['userCity'],
                                  );
                                  //calculate cart price
                                  // priceController.fetchProductPrice();
                                  return  Card(
                                    elevation: 1.0,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Image.network(userModel.userImg,height: 200,width: 200,fit: BoxFit.cover,),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Name'),
                                              Text(userModel.username)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Email'),
                                              Text(userModel.useremail)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Status'),
                                              Text(userModel.isActive.toString(),style: TextStyle(color: Colors.green),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );

                          }

                          return Container();
                        }
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
