import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/product-model.dart';
import 'package:foodie/utils/app-constant.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';
class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future:FirebaseFirestore.instance
        .collection('products')
        .where('isSale',isEqualTo:true)
        .get(),
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
              height: Get.height/3.5,

              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          // yani ki jo hum document ko fetch karna chah rhe h kya vh empty to nhi hai agr empty hai to yha par hum simple return karvayenge
          if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text('No flash sale found!!'),
            );
          }
          //
          if(snapshot.data!=null){
            return Container(
              height: Get.height/4.5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                    ProductModel productModel=ProductModel(
                        productId: snapshot.data!.docs[index]['productId'],
                        categoryId: snapshot.data!.docs[index]['categoryId'],
                        productName: snapshot.data!.docs[index]['productName'],
                        categoryName: snapshot.data!.docs[index]['categoryName'],
                        salePrice: snapshot.data!.docs[index]['salePrice'],
                        fullPrice: snapshot.data!.docs[index]['fullPrice'],
                        productImages: snapshot.data!.docs[index]['productImages'],
                        deliveryTime: snapshot.data!.docs[index]['deliveryTime'],
                        isSale: snapshot.data!.docs[index]['isSale'],
                        productDescription: snapshot.data!.docs[index]['productDescription'],
                        createdAt: snapshot.data!.docs[index]['createdAt'],
                        updatedAt: snapshot.data!.docs[index]['updatedAt']
                    );

                    return Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2.0),

                              child: Container(
                                //height: Get.height/3.0,
                                child: TransparentImageCard(
                                  borderRadius: 10.0,
                                  width: Get.width/3.0,
                                  height: Get.height/4.0,
                                  imageProvider: CachedNetworkImageProvider(
                                    productModel.productImages[0],
                                  ),
                                  title: Center(
                                      child: Text(
                                        productModel.productName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white,fontSize: 10.0),)
                                  ),

                                  footer: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Rs ${productModel.salePrice}",style: TextStyle(fontSize: 5.0,color: Colors.white,),),
                                      SizedBox(width: 70.0,),
                                      Text(" ${productModel.fullPrice}",style: TextStyle(fontSize: 5.0,decoration: TextDecoration.lineThrough,color: AppConstant.appSecondaryColor),)
                                    ],
                                  ),
                                  // tagSpacing: 10.0,
                                ),
                              ),
                            ),



                      ],
                    );

                  }),

            );
          }

          return Container();
        }
    );
  }
}
