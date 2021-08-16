import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app_hive/MainScreen.dart';
import 'package:movies_app_hive/Services/FirebaseServices.dart';
import 'package:movies_app_hive/Theme/theme.dart';
import 'package:movies_app_hive/User_Profile.dart';
import 'package:movies_app_hive/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [MyColors.primaryColor, MyColors.primaryColorLight])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
         body: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Image(
                   height: 350,
                   width: 350,
                   image: AssetImage("Images/image1.png"),),
               ),
             ),
             Center(
               child: RaisedButton.icon(
                 color: Colors.white,
                 onPressed: () async{
                    setState(() {
                   isLoading = true;
                 });
                 FirebaseService service = new FirebaseService();
                 try {
                  await service.signInwithGoogle();
                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Navbar()),
  );
                 } catch(e){
                   if(e is FirebaseAuthException){
                     showMessage(e.message!);
                   }
                 }
                 setState(() {
                   isLoading = false;
                 });
               },
               textColor: Colors.black,
                icon: Icon(FontAwesomeIcons.google, color: MyColors.primaryColor,) ,
               label: Padding(
                 padding: const EdgeInsets.symmetric(horizontal:18.0, vertical: 12),
                 child: Text("Sign In with Google"),
               )),
             ),
           ],
         ),

      )
      
    );
  }
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}