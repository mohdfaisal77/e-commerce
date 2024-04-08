import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/shared_pref.dart';
import 'package:e_commerce/widgets/AppImages.dart';
import 'package:e_commerce/widgets/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Details extends StatefulWidget {
  String image,name,detail,price;
   Details({required this.detail,required this.image,required this.name,required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a=1,total=0;
  String? id;
  gettheSharedPref()async{
    id=await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }
  ontheload()async{
    await gettheSharedPref();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
    total=int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 20,right: 20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             GestureDetector(
                 onTap: (){
                   Navigator.pop(context);
                 },
                 child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,)),
             SizedBox(height: 10,),
             Image.network(widget.image,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/2.5,fit: BoxFit.fill, ),
             SizedBox(height: 24.0,),
             
             Row(

               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.name,style: AppStyle.semiBoldTextFieldStyle(),),
                     // Text("Chicken Salan",style: AppStyle.boldTextFieldStyle(),),
                   ],
                 ),
                 Spacer(),
                 GestureDetector(
                   onTap: (){
                     if(a>1){
                       --a;
                       total=total - int.parse(widget.price);
                     }
                     setState(() {

                     });
                   },

                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.black,
                       borderRadius: BorderRadius.circular(8)
                     ),
                     child: Icon(Icons.remove,color: Colors.white,),
                   ),
                 ),
                 SizedBox(width: 20.0),
                 Text(a.toString(),style: AppStyle.semiBoldTextFieldStyle(),),
                 SizedBox(width: 20.0),
                 GestureDetector(
                   onTap: (){

                       ++a;
total=total+ int.parse(widget.price);
                     setState(() {
                     });
                   },
                   child: Container(
                     decoration: BoxDecoration(
                         color: Colors.black,
                         borderRadius: BorderRadius.circular(8)
                     ),
                     child: Icon(Icons.add,color: Colors.white,),
                   ),
                 ),
               ],
             ),
             SizedBox(height: 20.0,),
             Text(widget.detail),
             // Text("We're going to use Emmet abbreviation to generate lorem ipsum. VS Code supports the Emmet out of the box, so you don't need to install any extension. To generate a chunk of lorem ipsum text, simply type lorem in the editor.",maxLines: 4,style: AppStyle.lightTextFieldStyle(),),
           SizedBox(height: 30.0,),
           Row(
             children: [
               Text("Delivery Time",style: AppStyle.semiBoldTextFieldStyle(),),
               Icon(Icons.alarm,color: Colors.black,),
               SizedBox(width: 5.0,),
               Text('30 min',style: AppStyle.semiBoldTextFieldStyle(),),
             ],
           ),
             Spacer(),
             Padding(padding: EdgeInsets.only(bottom: 40),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Total Price',style: AppStyle.semiBoldTextFieldStyle(),),
                     Text('\$'+total.toString(),style: AppStyle.headerTextFieldStyle(),),
                   ],
                 ),
                 GestureDetector(
                   onTap: () async {
                     if (id != null) {
                       Map<String, dynamic> addFoodtoCart = {
                         "Name": widget.name,
                         "Quantity": a.toString(),
                         "Total": total.toString(),
                         "Image": widget.image
                       };
                       await DatabaseMethods().addFoodToCart(addFoodtoCart, id!);
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         backgroundColor: Colors.orangeAccent,
                         content: Text(
                           'Food Added to cart',
                           style: TextStyle(fontSize: 12.0),
                         ),
                       ));
                     } else {
                       // Handle the case where id is null
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         backgroundColor: Colors.red,
                         content: Text(
                           'User ID not found. Please try again.',
                           style: TextStyle(fontSize: 12.0),
                         ),
                       ));
                     }
                   },
                   child: Container(
                     width: MediaQuery.of(context).size.width / 2.5,
                     padding: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.black,
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text(
                           'Add to cart',
                           style: TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'Poppins'),
                         ),
                         SizedBox(width: 10.0,),
                         Container(
                           width: MediaQuery.of(context).size.width / 6,
                           decoration: BoxDecoration(
                             color: Colors.grey,
                             borderRadius: BorderRadius.circular(6),
                           ),
                           padding: EdgeInsets.all(4),
                           child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                         ),
                       ],
                     ),
                   ),
                 )

               ],
             ),
             )
           ],


        )
      ),
    );
  }
}
