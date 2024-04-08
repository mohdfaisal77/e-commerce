import 'package:e_commerce/pages/signUp.dart';
import 'package:e_commerce/widgets/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/content_model.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(top: 40,left: 20,right: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 40.0,),
                        Text(contents[i].title,style: AppStyle.semiBoldTextFieldStyle(),),
                        SizedBox(height:20.0 ,),
                        Text(contents[i].description,style: AppStyle.lightTextFieldStyle(),),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: 
                              List.generate(contents.length, (index) =>
                                buildDot(index,context),
                              )
                            
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(currentIndex==contents.length-1){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            }
                            _controller.nextPage(duration: Duration(milliseconds: 100), curve:Curves.bounceIn);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            height: 60.0,
                            margin: EdgeInsets.all(40),
                            
                            width: double.infinity,
                            child: Center(child: Text(currentIndex == contents.length-1 ? "Start":"Next",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
  Container buildDot(int index,BuildContext context){
    return  Container(
      height: 10.0,
      width: currentIndex== index ?18 : 7 ,
      margin: EdgeInsets.only(right:5 )
      ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),color: Colors.black12
      ),
    );
  }
}
