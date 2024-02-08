import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:foodie/models/cart-model.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';

import '../../../controllers/cart-price-controller.dart';
class CheckoutScren extends StatefulWidget {
  const CheckoutScren({super.key});

  @override
  State<CheckoutScren> createState() => _CheckoutScrenState();
}

class _CheckoutScrenState extends State<CheckoutScren> {
  User? user=FirebaseAuth.instance.currentUser;
  final ProductPriceController priceController=Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text('Checkout Screen',style: TextStyle(color: AppConstant.appTextColor,fontFamily: 'serif'),),
      ),
      body:StreamBuilder(
          stream :FirebaseFirestore.instance
              .collection('cart')
              .doc(user!.uid)
              .collection('cartOrders')
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
                child: Text('No flash-sale product found!!'),
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
                    CartModel cartModel=CartModel(
                      productId: productsData['productId'],
                      categoryId: productsData['categoryId'],
                      productName: productsData['productName'],
                      categoryName: productsData['categoryName'],
                      salePrice: productsData['salePrice'],
                      fullPrice: productsData['fullPrice'],
                      productImages:productsData['productImages'],
                      deliveryTime: productsData['deliveryTime'],
                      isSale: productsData['isSale'],
                      productDescription: productsData['productDescription'],
                      createdAt: productsData['createdAt'],
                      updatedAt:productsData['updatedAt'],
                      productQuantity:productsData['productQuantity'],
                      productTotalPrice:productsData['productTotalPrice'],
                    );
                    //calculate cart price
                    priceController.fetchProductPrice();
                    return SwipeActionCell(
                        key: ObjectKey(cartModel.productId),
                        trailingActions: [
                          SwipeAction(
                            title: "Delete",
                            forceAlignmentToBoundary: true,
                            performsFirstActionWithFullSwipe: true,
                            onTap: (CompletionHandler handler) async{
                              await FirebaseFirestore.instance
                                  .collection('cart')
                                  .doc(user!.uid)
                                  .collection('cartOrders')
                                  .doc(cartModel.productId)
                                  .delete();
                              Get.snackbar(
                                "Item Deleted",
                                "",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: AppConstant.appSecondaryColor,
                                colorText: AppConstant.appTextColor,
                              );
                            },
                          )
                        ],
                        child: Card(
                          elevation: 14.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(cartModel.productImages[0]),
                            ),
                            title: Text(cartModel.productName),
                            subtitle: Row(
                              children: [
                                Text(cartModel.productTotalPrice.toString()),
                              ],
                            ),
                          ),
                        )
                    );
                  }
              );

            }

            return Container();
          }
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
                  Obx(
                          ()=>Text(priceController.totalPrice.value.toString(),style: TextStyle(color: Colors.red,fontFamily: 'serif',fontWeight: FontWeight.bold,fontSize: 14),)),
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
                          onPressed: (){
                            showCustomBottomSheet();
                          },
                          child: Text('Confirm Order',
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
void showCustomBottomSheet(){
  Get.bottomSheet(
    Container(
      height: Get.height*0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Near by landmark',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstant.appSecondaryColor,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
              ),
                onPressed: (){}, 
                child: Text('Place Order',style: TextStyle(color: AppConstant.appTextColor),)
            )
          ],
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    isDismissible: true,
    elevation: 6,
    enableDrag: true

  );
}

