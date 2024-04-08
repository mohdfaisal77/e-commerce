import 'dart:convert';

import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/shared_pref.dart';
import 'package:e_commerce/widgets/app_constant.dart';
import 'package:e_commerce/widgets/app_style.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'package:http/http.dart' as http;
import '../widgets/AppImages.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController amountController=new TextEditingController();
  int? add;
  Map<String, dynamic>? paymentIntent;
  String? wallet,id;
  gettheSharedpref()async{
    wallet= await SharedPreferenceHelper().getUserWallet();
    id=await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }
  ontheload() async {
    await gettheSharedpref();
    setState(() {

    });
  }
  @override
  void initState() {
    ontheload();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: wallet== null ? CircularProgressIndicator(): Container(
      //   margin: const EdgeInsets.only(top: 60.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Material(
      //         elevation: 2.0,
      //         child: Container(
      //           padding: EdgeInsets.only(bottom: 10.0),
      //           child: Center(
      //             child: Text(
      //               "Wallet",
      //               style: AppStyle.headerTextFieldStyle(),
      //             ),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 30.0,
      //       ),
      //       Container(
      //         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      //         width: MediaQuery.of(context).size.width,
      //         decoration: const BoxDecoration(
      //           color: Color(0xFFF2f2F2),
      //         ),
      //         child: Row(
      //           children: [
      //             Image.asset(
      //               AppImages.ice_cream,
      //               height: 60.0,
      //               width: 60.0,
      //               fit: BoxFit.cover,
      //             ),
      //             SizedBox(
      //               height: 40.0,
      //             ),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   "Your wallet",
      //                   style: AppStyle.lightTextFieldStyle(),
      //                 ),
      //                 const SizedBox(
      //                   height: 5.0,
      //                 ),
      //                 Text(
      //                   "\$ " + "100",
      //                   style: AppStyle.boldTextFieldStyle(),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 20.0,
      //       ),
      //       Padding(
      //           padding: const EdgeInsets.only(left: 20.0),
      //           child: Text(
      //             "Add Money",
      //             style: AppStyle.semiBoldTextFieldStyle(),
      //           )),
      //       SizedBox(
      //         height: 10.0,
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           GestureDetector(
      //             onTap: (){
      //               makePayment('100');
      //             },
      //             child: Container(
      //               padding: EdgeInsets.all(5.0),
      //               decoration: BoxDecoration(
      //                   border: Border.all(color: Colors.green),
      //                   borderRadius: BorderRadius.circular(5)),
      //               child: Text(
      //                 "\$" + wallet!,
      //                 style: AppStyle.semiBoldTextFieldStyle(),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: (){
      //               makePayment('500');
      //             },
      //             child: Container(
      //               padding: const EdgeInsets.all(5.0),
      //               decoration: BoxDecoration(
      //                   border: Border.all(color: Colors.green),
      //                   borderRadius: BorderRadius.circular(5)),
      //               child: Text(
      //                 "\$" + "500",
      //                 style: AppStyle.semiBoldTextFieldStyle(),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: (){
      //               makePayment('1000');
      //             },
      //             child: Container(
      //               padding: EdgeInsets.all(5.0),
      //               decoration: BoxDecoration(
      //                   border: Border.all(color: Colors.green),
      //                   borderRadius: BorderRadius.circular(5)),
      //               child: Text(
      //                 "\$" + "1000",
      //                 style: AppStyle.semiBoldTextFieldStyle(),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: (){
      //               makePayment('2000');
      //             },
      //             child: Container(
      //               padding: EdgeInsets.all(5.0),
      //               decoration: BoxDecoration(
      //                   border: Border.all(color: Colors.green),
      //                   borderRadius: BorderRadius.circular(5)),
      //               child: Text(
      //                 "\$" + "2000",
      //                 style: AppStyle.semiBoldTextFieldStyle(),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //       SizedBox(
      //         height: 50.0,
      //       ),
      //       GestureDetector(
      //         onTap: (){
      //           openEdit();
      //         },
      //         child: Container(
      //           margin: EdgeInsets.symmetric(horizontal: 20.0),
      //           padding: EdgeInsets.symmetric(vertical: 12.0),
      //           width: MediaQuery.of(context).size.width,
      //           decoration: BoxDecoration(
      //               color: Colors.greenAccent,
      //               borderRadius: BorderRadius.circular(8)),
      //           child: Text(
      //             "Add Money",
      //             style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 16.0,
      //                 fontWeight: FontWeight.bold,
      //                 fontFamily: "Poppins"),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

//   Future<void> makePayment(String amount) async {
//     try {
//       paymentIntent = await createPaymentIntent(amount, 'INR');
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   paymentIntentClientSecret: paymentIntent!['client_secret'],
//                   style: ThemeMode.dark,
//                   merchantDisplayName: "Faisal"))
//           .then((value) {});
//       displayPaymentSheet(amount);
//     } catch (e, s) {
//       print('exception: $e$s');
//     }
//   }
//
//   displayPaymentSheet(String amount) async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) async {
// add= int.parse(wallet!)+ int.parse(amount);
// await SharedPreferenceHelper().saveUserWallet(add.toString());
// await DatabaseMethods().updateUserWallet(id!,add.toString() );
//
//
//
//
//
//         showDialog(
//             context: context,
//             builder: (_) => const AlertDialog(
//                   content: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.check_circle, color: Colors.greenAccent),
//                           Text("Payment Successfully")
//                         ],
//                       )
//                     ],
//                   ),
//                 ));
// await gettheSharedPref();
//         // await usergetprofile();
//         paymentIntent = null;
//       }).onError((error, stackTrace) {
//
//           print('Error is: ----> $error $stackTrace');
//
//       });
//     } on StripeException catch (e) {
//
//         print("Error is $e");
//
//       showDialog(
//           context: context,
//           builder: (_) => const AlertDialog(
//                 content: Text('Cancelled'),
//               ));
//     } catch (e) {
//       print("$e");
//     }
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//       var response = await http.post(
//         Uri.parse('http://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       print('Payment Intent Body --> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user ${err.toString()}');
//     }
//   }
//
//   calculateAmount(String amount) {
//     final calculateAmount = (int.parse(amount) * 100);
//     return calculateAmount.toString();
//   }
//   Future openEdit()=> showDialog(context: context, builder: (context)=>AlertDialog(
//     content: SingleChildScrollView(
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: (){
//                    Navigator.pop(context);
//                   },
//                   child: Icon(Icons.cancel),
//                 ),
//                 SizedBox(height: 60.0,),
//                 Center(
//                   child: Text("Add Money",style:TextStyle(
//                     color: Colors.lightGreenAccent,
//                     fontWeight: FontWeight.bold
//                   ),),
//                 ),
//
//               ],
//             ),  SizedBox(height: 20.0,),
//             Text('Amount'),
//             SizedBox(height: 10.0,),
//             Container(
// padding: EdgeInsets.symmetric(horizontal: 10.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color:Colors.black38,width: 2.0,),borderRadius: BorderRadius.circular(10.0)
//               ),
//               child: TextField(
//                 controller: amountController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,hintText: "Enter Amount"
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0,),
//             Center(
//               child: GestureDetector(
//                 onTap: (){
//                   Navigator.pop(context);
//                   makePayment(amountController.text);
//                 },
//                 child: Container(
//                   width: 100,
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: Colors.greenAccent,
//                       borderRadius: BorderRadius.circular(10.0)
//                   ),
//                   child: Center(
//                     child: Text('Pay'),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   ));
}
