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
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  final ProductPriceController priceController=Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text('Cart Screen',style: TextStyle(color: AppConstant.appTextColor,fontFamily: 'serif'),),
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
                              SizedBox(width: Get.width/20.0,),
                              GestureDetector(
                                onTap: () async{
                                  //agr item ki qty badi h 1 se
                                  if(cartModel.productQuantity>1){
                                   await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update(
                                        {
                                          'productQuantity':cartModel.productQuantity-1,
                                          'productTotalPrice': (double.parse(cartModel.fullPrice)*(cartModel.productQuantity-1))
                                        });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: AppConstant.appSecondaryColor,
                                  child: Text("-"),
                                ),
                              ),
                              SizedBox(width: Get.width/20.0,),
                              Text(cartModel.productQuantity.toString()),
                              SizedBox(width: Get.width/20.0,),
                              GestureDetector(
                                onTap: () async{
                                  //agr item ki qty badi h 0 se to yah ++ hoga
                                  if(cartModel.productQuantity>0){
                                   await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update(
                                        {
                                          'productQuantity':cartModel.productQuantity+1,
                                          'productTotalPrice': double.parse(cartModel.fullPrice)+double.parse(cartModel.fullPrice)*(cartModel.productQuantity)
                                        });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: AppConstant.appSecondaryColor,
                                  child: Text("+"),
                                ),
                              )
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

