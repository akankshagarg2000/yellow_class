import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app_hive/LoginPage.dart';
import 'package:movies_app_hive/MainScreen.dart';
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

  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {

      runApp(
    MaterialApp(
    home: LoginPage(),
  
  ));
      print('User is currently signed out!');
    } else {
      runApp(
    MaterialApp( 
    home: Navbar(),
  ));
      print('User is signed in!');
    }
  });
  
}



