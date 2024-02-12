import 'dart:math';
String genrateOrderId(){

  DateTime now=DateTime.now();

  int randomNumbers=Random().nextInt(999999);
  String id='${now.microsecondsSinceEpoch}_$randomNumbers';
  return id;
}