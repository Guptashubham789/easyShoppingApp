import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/product-model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';

import '../../models/categories-model.dart';
import '../../utils/app-constant.dart';
class SingleCategoriProduct extends StatefulWidget {
  String categoryId;
  String categoryName;
   SingleCategoriProduct({super.key, required String this.categoryId, required String this.categoryName});

  @override
  State<SingleCategoriProduct> createState() => _SingleCategoriProductState();
}

class _SingleCategoriProductState extends State<SingleCategoriProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,

        title: Text(widget.categoryName,style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: FutureBuilder(future:FirebaseFirestore.instance.collection('products').where('categoryId',isEqualTo: widget.categoryId).get(),
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
                child: Text('No categories found!!'),
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
                  //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                  //
                  final productData=snapshot.data!.docs[index];
                  ProductModel productModel=ProductModel(
                      productId: productData['productId'],
                      categoryId: productData['categoryId'],
                      productName: productData['productName'],
                      categoryName: productData['categoryName'],
                      salePrice: productData['salePrice'],
                      fullPrice: productData['fullPrice'],
                      productImages: productData['productImages'],
                      deliveryTime: productData['deliveryTime'],
                      isSale: productData['isSale'],
                      productDescription: productData['productDescription'],
                      createdAt: productData['createdAt'],
                      updatedAt: productData['updatedAt'],
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                        },
                        child: Padding(padding: EdgeInsets.all(8.0),
                          child: Container(

                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width / 2.3,
                              heightImage: Get.height / 10,
                              imageProvider: CachedNetworkImageProvider(
                                  productModel.productImages[0]),
                              title: Center(child: Text(productModel.categoryName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black87, fontSize: 10.0,fontFamily: "serif"),)),

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
