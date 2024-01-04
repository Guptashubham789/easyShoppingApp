class UserModel{
  final String uId;
  final String username;
  final String useremail;
  final String userphone;
  final String userImg;
  final String userDeviceToken;
  final String usercountry;
  final String userAddress;
  final String userStreet;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;

  UserModel({
    required this.uId,
    required this.username,
    required this.useremail,
    required this.userphone,
    required this.userImg,
    required this.userDeviceToken,
    required this.usercountry,
    required this.userAddress,
    required this.userStreet,
    required this.isActive,
    required this.isAdmin,
    required this.createdOn,
});
  //Serialize the UserModel instance to a JSON map

    Map<String,dynamic> toMap(){
      return {
        'uId':uId,
        'username':username,
        'useremail':useremail,
        'userphone':userphone,
        'userImg':userImg,
        'userDeviceToken':userDeviceToken,
        'usercountry':usercountry,
        'useraddress':userAddress,
        'userstreet':userStreet,
        'isAdmin': isAdmin,
        'isActive':isActive,
        'createdOn':createdOn,
      };
    }

    //create a UserModel instance from a json map

  factory UserModel.fromMap(Map<String,dynamic> json){
      return UserModel(
          uId: json['uId'],
          username: json['username'],
          useremail: json['useremail'],
          userphone: json['userphone'],
          userImg: json['userImg'],
          userDeviceToken: json['userDeviceToken'],
          usercountry: json['usercountry'],
          userAddress: json['useraddress'],
          userStreet: json['userstreet'],
          isActive: json['isActive'],
          isAdmin: json['isAdmin'],
          createdOn: json['createdOn']
      );
  }


}