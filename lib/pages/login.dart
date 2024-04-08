import 'dart:core';
import 'dart:core';

import 'package:e_commerce/pages/format_password.dart';
import 'package:e_commerce/pages/signUp.dart';
import 'package:e_commerce/widgets/AppImages.dart';
import 'package:e_commerce/widgets/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey= GlobalKey<FormState>();
  String email="";

  String password="";
TextEditingController userEmailController= new TextEditingController();
  TextEditingController userPasswordController= new TextEditingController();

  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text(
            "The user not found for that email",
            style: TextStyle(fontSize: 18,color: Colors.black),

          ),
        )));
      }else if(e.code=="wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text(
            "Please enter correct password",
            style: TextStyle(fontSize: 18,color: Colors.black),
          ),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration
                (

                gradient:LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFFff5c30),Color(0xFFe74b1a),
                ])
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/2),
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:
                Radius.circular(30))
              ),
              child: Text(''),
            ),
            Container(

              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Center(child:Image.asset(AppImages.pizza,width: MediaQuery.of(context).size.width/2,fit: BoxFit.cover,))
                ,
                  // SizedBox(height: 10.0,)
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 5.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0,right: 20.0),
                      width: MediaQuery.of(context).size.width/1.1
                      ,
                      height: MediaQuery.of(context).size.height/2,
                      decoration:BoxDecoration(
                        color: Colors.white,borderRadius: BorderRadius.circular(20)

                      ),child: Form(
                      key: _formKey,
                        child: Column(

                        children: [
                          SizedBox(height: 30,),
                        Text("Login",style: AppStyle.headerTextFieldStyle(),),
                          SizedBox(height: 30,),
                          TextFormField(
                            controller: userEmailController,
                            validator: (value){
                              if( value== null || value.isEmpty){
                                return "plaese enter your email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: AppStyle.semiBoldTextFieldStyle(),
                              prefixIcon: Icon(Icons.email_outlined)
                            ),
                          ),

                          SizedBox(height: 30,),
                          TextFormField(
                            obscureText: true,
                            controller: userPasswordController,
                            validator: (value){
                              if( value== null || value.isEmpty){
                                return "plaese enter your Password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Password',

                                hintStyle: AppStyle.semiBoldTextFieldStyle(),
                                prefixIcon: Icon(Icons.password_outlined)
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          GestureDetector(
                            onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgatPassword()));},
                            child: Container(
                                alignment: Alignment.topRight,
                                child: Text("Forgat Password",style: AppStyle.semiBoldTextFieldStyle(),)),
                          )
                             ,
                          SizedBox(height: 80.0,),
                          GestureDetector(
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  email=userEmailController.text.toString();
                                  password=userPasswordController.text.toString();
                                });

                              }
                              userLogin();
                            },
                            child: Material(
                              elevation: 5.0,
                                borderRadius: BorderRadius.circular(20),
                              child:Container(padding: EdgeInsets.symmetric(vertical: 8.0),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Color(0xffff5722),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text('Login',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18,fontFamily: 'Poppins'),)),
                              )
                            ),
                          ),

                              ],
                                            ),
                      ),),
                  ),
                  SizedBox(height: 70.0,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                      child: Text("Don't have an account? Sign Up",style: AppStyle.semiBoldTextFieldStyle(),))
                ]

              ),
            )
          ],
        ),
      ),
    );
  }
}
