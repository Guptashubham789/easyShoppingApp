import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../services/contacts-service.dart';
import '../../utils/app-constant.dart';
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController subjectController=TextEditingController();
  TextEditingController messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Contacts',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              Center(
                child: Text('GET IN TOUCH'),
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    child: Card(

                       // color: AppConstant.appSecondaryColor,
                        elevation: 14,
                        child: Image.network('https://guptabhelpuriandsandwich.web.app/images/owner.jpg',
                          height: 150,
                          width: 300,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Prakash Gupta || Bablu Gupta',style: TextStyle(fontFamily: AppConstant.appFontFamily),maxLines: 4,),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    child: Card(
                        color: AppConstant.appSecondaryColor,
                        elevation: 14,
                        child: Icon(Icons.phone)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('+91-9594419414,',style: TextStyle(fontFamily: AppConstant.appFontFamily),maxLines: 4,),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                   Container(
                        height: 75,
                        width: 75,
                        child: Card(
                          color: AppConstant.appSecondaryColor,
                          elevation: 14,
                            child: Icon(Icons.location_on)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Shop no 1,Malad Nadiyawala\nColony 1  Malad West Mumbai\n Maharashtra 400064',style: TextStyle(fontFamily: AppConstant.appFontFamily),maxLines: 4,),
                      )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                child: Container(
                  width: Get.width/2.0,
                  height: Get.height/18,
                  decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: TextButton(
                      onPressed: (){
                        showCustomBottomSheet();
                      },
                      child: Text('SEND MESSAGE',
                        style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void showCustomBottomSheet(){
    Get.bottomSheet(
        Container(
          height: Get.height*1.2,
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
                      controller: nameController,
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
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                      controller: subjectController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Subject',
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
                      controller: messageController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Material(
                  child: Container(
                    width: Get.width/2.0,
                    height: Get.height/18,
                    decoration: BoxDecoration(
                        color: AppConstant.appSecondaryColor,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextButton(
                        onPressed: (){
                          String name=nameController.text.trim();
                          String email=emailController.text.trim();
                          String subject=subjectController.text.trim();
                          String message=messageController.text.trim();
                         // String customerToken=await getCustomerDeviceToken();
                          sendMessage(
                            context:context,
                            customerName:name,
                            customerEmail:email,
                            customerSubject:subject,
                            customerMessage:message,
                          );
                        },
                        child: Text('SEND MESSAGE',
                          style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),)
                    ),
                  ),
                ),

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
}

