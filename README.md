# foodie

A new Flutter project.

## Getting Started

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
