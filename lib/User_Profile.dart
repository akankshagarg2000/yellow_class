import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_hive/LoginPage.dart';
import 'package:movies_app_hive/Services/FirebaseServices.dart';
import 'package:movies_app_hive/Theme/theme.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({ Key? key }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.primaryColor,
      title: Text("User Profile"),),
      body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2),
              child: Card(
                elevation: 3,
                shadowColor: MyColors.primaryColorLight,
                child: ListTile(
                  title: Text("Email"),
                  subtitle: Text(user!.email!))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2),
              child: Card(
                elevation: 3,
                shadowColor: MyColors.primaryColorLight,
                child: ListTile(
                  title: Text("Username"),
                  subtitle: Text(user!.displayName!))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async{
                  FirebaseService service = new FirebaseService();
                  print(user!.email);
                  await service.signOutFromGoogle();
                  print(user!.email);
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
                },
                child: Card(
                  elevation: 3,
                  shadowColor: MyColors.primaryColorLight,
                  child: ListTile(title: Text("Logout"),
                trailing: Icon(Icons.logout_rounded),),),
              ),
            )
          ],
        )));
    
  }
}