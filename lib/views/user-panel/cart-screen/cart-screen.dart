import 'package:flutter/material.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appSecondaryColor,
        title: Center(child: Text('Cart Screen',style: TextStyle(color: AppConstant.appTextColor,fontFamily: 'serif'),)),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 20,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index){
              return Card(
                color: AppConstant.appTextColor,
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppConstant.appSecondaryColor,
                    child: Text('N'),
                  ),
                  title: Text('SSG'),
                  subtitle: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2200'),
                      SizedBox(width: Get.width/20.0,),
                      CircleAvatar(
                        radius: 14.0,
                        backgroundColor: AppConstant.appSecondaryColor,
                        child: Text('+'),
                      ),
                      SizedBox(width: 20,),
                      CircleAvatar(
                        radius: 14.0,
                        backgroundColor: AppConstant.appSecondaryColor,
                        child: Text('-'),
                      ),
                    ],
                  ),
                ),
              );
            }
        )
        ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.5),
        child: Row(
          children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                  children: [
                    Text(' Total : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'serif'),),
                    SizedBox(width: Get.width/40,),
                    Text('1200'),
                    SizedBox(width: Get.width/20,),
                    Material(
                      child: Container(
                        width: Get.width/2.0,
                        height: Get.height/18,
                        decoration: BoxDecoration(
                          color: AppConstant.appSecondaryColor,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: TextButton(
                            onPressed: (){},
                            child: Text('Checkout',
                            style: TextStyle(color: AppConstant.appTextColor),)
                        ),
                      ),
                    )
                  ],
            ),
               )
          ],
        ),
      ),
    );
  }
}
