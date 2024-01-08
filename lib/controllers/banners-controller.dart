import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../utils/app-constant.dart';

class bannersController extends GetxController{
  RxList<String> bannerUrls=RxList<String>([]);

  @override
  void onInit(){
    super.onInit();
    fetchbannersUrls();
  }
  //fetch banners

  Future<void> fetchbannersUrls() async{
    try{
        QuerySnapshot bannersSnapshot=
            await FirebaseFirestore.instance.collection('banners').get();
        //agr yah empty nhi hai to es case me aa jaye
        if(bannersSnapshot.docs.isNotEmpty){
          //upr jo maine var bnaya hai uske ander hum apne banner ke doc ke field ko store karenge as a imageUrl
          bannerUrls.value=
              bannersSnapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
        }
    }catch(e){
      Get.snackbar(
        "banner error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
