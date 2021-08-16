import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app_hive/Theme/theme.dart';
import 'package:movies_app_hive/home.dart';
import 'package:movies_app_hive/movie_model.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DataModelAdapter());

  
  runApp(
    MaterialApp(
    home: Home(),
  
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [MyColors.primaryColorLight, MyColors.primaryColor
      ])
  ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom( 
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size (300, 50),

              ),
            onPressed: (){
              // final provider = Provider.of(context, listen:false);
              // provider.googleLogin();
            },
             icon: FaIcon(FontAwesomeIcons.google , color: MyColors.primaryColorLight,),
              label: Text("Sign In with Google"),
              )
        )
        
      ),
    );
  }
}