import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce/pages/home.dart';
import 'package:e_commerce/pages/profile.dart';
import 'package:e_commerce/pages/wallet.dart';
import 'package:flutter/material.dart';

import 'order.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex=0;
  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Order order;
  late Profile profile;
  late Wallet wallet;

  @override
  void initState() {
    homepage=const Home();
    order=const Order();
    profile=const Profile();
    wallet=const Wallet();
    pages=[homepage,order,wallet,profile];
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });
        },
        items: [
          Icon(Icons.home_outlined,color: Colors.white,),
          Icon(Icons.shopping_bag_outlined,color: Colors.white,),
          Icon(Icons.wallet_outlined,color: Colors.white,),
          Icon(Icons.person_outlined,color: Colors.white,)
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
