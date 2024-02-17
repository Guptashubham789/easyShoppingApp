class ContactsModel{
  final String uId;
  final String username;
  final String useremail;
  final String usersubject;
  final String userMessage;
  final dynamic createdOn;


  ContactsModel({
    required this.uId,
    required this.username,
    required this.useremail,
    required this.usersubject,
    required this.userMessage,

    required this.createdOn,

  });
  //Serialize the ContactsModel instance to a JSON map

  Map<String,dynamic> toMap(){
    return {
      'uId':uId,
      'username':username,
      'useremail':useremail,


      'usersubject':usersubject,
      'userMessage':userMessage,

      'createdOn':createdOn,

    };
  }

  //create a ContactsModel instance from a json map

  factory ContactsModel.fromMap(Map<String,dynamic> json){
    return ContactsModel(
        uId: json['uId'],
        username: json['username'],
        useremail: json['useremail'],
      usersubject: json['usersubject'],
      userMessage: json['userMessage'],

        createdOn: json['createdOn'],

    );
  }


}