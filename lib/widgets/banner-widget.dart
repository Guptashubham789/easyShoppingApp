import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/controllers/banners-controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController=CarouselController();
  final bannersController _bannerController=Get.put(bannersController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
          return CarouselSlider(
              items: _bannerController.bannerUrls.map(
                    (imageUrl) => ClipRRect(
                        borderRadius:BorderRadius.circular(10.0),

                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: Get.width-10,
                        placeholder: (context,url)=>ColoredBox(
                          color: Colors.white,
                          child:Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                          errorWidget: (context,url,error)=>Icon(Icons.error),
                        ),
                    ),
              ).toList(),
              options: CarouselOptions(
                height: 200.0,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
          );
      }),
    );
  }
}
