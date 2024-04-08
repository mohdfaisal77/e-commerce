import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/details.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/widgets/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/AppImages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  Stream? foodItemStream;

  ontheload() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    // TODO: implement initState
    super.initState();
  }

  Widget allItemsVertically() {
    return StreamBuilder(

        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(

                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"], image: ds["Image"], name: ds["Name"], price: ds["Price"],)));
                      },
                      child: Container(
                       margin: EdgeInsets.only(right: 20.0,bottom: 20.0),

                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                ds["Image"],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Text(
                                      ds["Name"],
                                      style: AppStyle.semiBoldTextFieldStyle(),
                                    )),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Text(
                                      "Honey goot cheese",
                                      style: AppStyle.lightTextFieldStyle(),
                                    )),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Text(
                                      "\$"+ds["Price"],
                                      style: AppStyle.semiBoldTextFieldStyle(),
                                    ))
                              ],
                            )
                          ],
                        ),
                        ),
                      ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  Widget allItems() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"], image: ds["Image"], name: ds["Name"], price: ds["Price"],)));
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      ds["Image"],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )),
                                Text(
                                  ds["Name"],
                                  style: AppStyle.semiBoldTextFieldStyle(),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Fresh and Healthy",
                                  style: AppStyle.lightTextFieldStyle(),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\$" + ds["Price"],
                                  style: AppStyle.semiBoldTextFieldStyle(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 14,
            top: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Faisal", style: AppStyle.boldTextFieldStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 14),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Delicious Food", style: AppStyle.headerTextFieldStyle()),
              Text("Discover and Get Great Food",
                  style: AppStyle.lightTextFieldStyle()),
              SizedBox(
                height: 20,
              ),
              Container(margin: EdgeInsets.only(right: 14), child: showItem()),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 270,
                child: allItems(),
              ),
              SizedBox(
                height: 10.0,
              ),
              allItemsVertically(),

              // Material(
              //   elevation: 5.0,
              //   borderRadius: BorderRadius.circular(20),
              //   child:
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            foodItemStream= await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                AppImages.ice_cream,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            foodItemStream= await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                AppImages.pizza,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            foodItemStream= await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                AppImages.salad,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            foodItemStream= await DatabaseMethods().getFoodItem("Burgur");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(AppImages.burger,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  color: burger ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
