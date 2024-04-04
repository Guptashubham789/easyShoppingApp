# foodie

A new Flutter food project.

## Output
## Splash Screen

![WhatsApp Image 2024-04-04 at 09 16 53_0c012144](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/3ab17fad-91e0-4713-a617-cc79fdcba2f4)
![WhatsApp Image 2024-04-04 at 09 16 54_af12446f](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/850dfe52-53b6-439c-b54e-b0bb67afd262)

## Welcome Screen
![WhatsApp Image 2024-04-04 at 09 16 54_7e855012](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/83711cbc-e67b-4131-b005-5ef9aeaa1d46)
## Home Screen
![WhatsApp Image 2024-04-04 at 09 16 57_6e6bcf9a](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/a2b7435f-bd25-49f8-89db-161e1fd0ec29)
![WhatsApp Image 2024-04-04 at 09 16 58_0a5e43c2](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/1607cf82-9dee-49e1-8cbd-b90f97576929)
## Category Screen
![WhatsApp Image 2024-04-04 at 09 16 58_605ea570](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/7e6823b1-ce82-4d34-96f4-e2afac7a3e4d)
## Drawer Screen
![WhatsApp Image 2024-04-04 at 09 16 59_143663f9](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/3fcf5889-a25b-45b6-b817-71463de6d0d8)
## All Products Screen
![WhatsApp Image 2024-04-04 at 09 16 59_460d7e59](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/60381513-1636-4b94-80ba-5296792dc749)
## Product Details
![WhatsApp Image 2024-04-04 at 09 17 01_9789ba1d](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/5b0d81e3-d2cd-4240-b278-6818600422e3)
## Cart Screen
![WhatsApp Image 2024-04-04 at 09 16 59_d5686fd3](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/f6db6a51-b591-449d-9927-245990cb5439)
## All Pending Order Screen
![WhatsApp Image 2024-04-04 at 09 17 00_aae8e2bc](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/0c69f699-63ac-4689-baba-d29fee646874)
## User Profile Screen
![WhatsApp Image 2024-04-04 at 09 17 00_d0e7c93b](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/df178a92-d039-4aaf-912d-62d0e98485d2)
## Contacts Screen
![WhatsApp Image 2024-04-04 at 09 17 01_dd752471](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/7bd31833-b9f7-4822-9714-cb9ae93b2fc8)
## Wishlist Screnn
![WhatsApp Image 2024-04-04 at 09 17 02_4331ce3a](https://github.com/Guptashubham789/easyShoppingApp/assets/92355902/4b6b38e1-f0b2-4518-9486-eb75054a26fc)


//cart screen 
step 1: sabse phle hum cart ki screen ko design kar lenge ek screen bnaa ke 
step 2: ab hum model bnaayenge and usme hum 2 chije add kar lenge product ki qnty and product total price 
and fields productid,categoryid,productname,categoryname etc,
step 3: ab hum sabse phle product details screen par jaake ek method create karenge checkProductAddToCart() and eske phle hum user ki current id ko nikal lenge
step 4: ab hum ek collation bnayenge firestore me cart name se jo user ki id method se hum get kar rhe the ab hum use cart ke collation me insert me karenge and ek documnet bnayenge
//
final DocumentReference documentReference=FirebaseFirestore.instance
.collection('cart')
.doc(uId)
.collection('cartOrders') //jo bhi apne cart ke ander product store honge usko apni id ke base par insert karenge
.doc(widget.productModel.productId);
har user ko usi ke product dikhane hai 
