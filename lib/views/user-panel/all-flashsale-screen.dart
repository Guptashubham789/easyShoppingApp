import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/product-model.dart';
import 'package:foodie/views/user-panel/product-details-screen.dart';
import 'package:foodie/views/user-panel/single-category-products.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';

import '../../models/categories-model.dart';
import '../../utils/app-constant.dart';

class AllFlashSaleScreen extends StatefulWidget {
  const AllFlashSaleScreen({super.key});

  @override
  State<AllFlashSaleScreen> createState() => _AllFlashSaleScreenState();
}

class _AllFlashSaleScreenState extends State<AllFlashSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('All FlashSale',style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: FutureBuilder(
          future:FirebaseFirestore.instance.collection('products').where('isSale',isEqualTo: true).get(),
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
                child: Text('Today is not sale 😄!!',style: TextStyle(color: AppConstant.appSecondaryColor,fontSize: 16,fontFamily: 'serif'),),
              );
            }
            //
            if(snapshot.data!=null){
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 1.19
                ),
                itemBuilder: (context,index) {
                  //yha par ek var par product ke data kka snapshot nikal lenge jisse hum id ke through data ko product model me gate kar sakte hai
                  final productsData=snapshot.data!.docs[index];
                  ProductModel productModel=ProductModel(
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
                      updatedAt:productsData['updatedAt']
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>ProductDetailsScreen(productModel:productModel));
                        },
                        child: Padding(padding: EdgeInsets.all(8.0),
                          child: Container(

                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width / 2.3,
                              heightImage: Get.height / 10,
                              imageProvider: CachedNetworkImageProvider(
                                  productModel.productImages[0]),
                              title: Center(child: Text(productModel.productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(color: Colors.black87, fontSize: 10.0,fontFamily: "serif"),)
                              ),
                              footer: Row(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rs ${productModel.salePrice}",style: TextStyle(fontSize: 6.0,color: Colors.black87,),),
                                  SizedBox(width: 100.0,),
                                  Text(" ${productModel.fullPrice}",style: TextStyle(fontSize: 5.0,decoration: TextDecoration.lineThrough,color: AppConstant.appSecondaryColor),),

                                ],
                              ),
                              

                            ),
                          ),
                        ),
                      ),

                    ],
                  );
                },

              );

            }

            return Container();
          }
      ),
    );
  }
}
