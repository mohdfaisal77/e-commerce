import 'package:e_commerce/pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgatPassword extends StatefulWidget {
  const ForgatPassword({super.key});

  @override
  State<ForgatPassword> createState() => _ForgatPasswordState();
}

class _ForgatPasswordState extends State<ForgatPassword> {
  TextEditingController _mailController = new TextEditingController();
String email="";
final _formKey=GlobalKey<FormState>();
resetPassword()async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password reset email has been sent',style: TextStyle(fontSize: 10.0),)));
  }on FirebaseAuthException catch(e){
    if(e.code== 'user-not-found'){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found for that email',style: TextStyle(fontSize: 10.0),)));
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          child: Column(children: [
        SizedBox(height: 70.0),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Forgat Password",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Enetr your email",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: Form(
              key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: ListView(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: _mailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.white),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: 30.0,
                          )),
                    )),
                SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        email=_mailController.text.toString();
                      });
                      resetPassword();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 60),
                    width: 140,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Send Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account",style: TextStyle(fontSize:18.0,color: Colors.white),),
                    GestureDetector(
                      onTap:() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("Create",style: TextStyle(
                          color: Color.fromARGB(255, 144, 166, 6),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        ),


      ])),
    );
  }
}
