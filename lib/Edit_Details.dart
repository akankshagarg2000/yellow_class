import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app_hive/Theme/theme.dart';
import 'package:movies_app_hive/movie_model.dart';


// ignore: must_be_immutable
class EditMovie extends StatefulWidget {
  late int index;
  EditMovie({required this.index});
  

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  
  TextEditingController movieTitleController = TextEditingController();
  TextEditingController directorController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        automaticallyImplyLeading: true,
        title: Text("Edit Movie Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 140,
                  width: 140,
                  color: MyColors.primaryColorLight,
                  child: Icon(Icons.camera_alt_rounded,
                  size: 50,),
                ),
              ),
            Padding (

                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: movieTitleController,
                  
                   decoration: InputDecoration(
                    labelText: 'Movie Title',
                    border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular (5.0)

                        )  
                    ), 
                ), 
      ), 


      Padding (

                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: directorController,
                  
                   decoration: InputDecoration(
                    labelText: 'Director Name',
                    border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular (5.0)

                        )  
                    ), 
                ), 
      ),

      RaisedButton(
        onPressed: (){
          DataModel mData = DataModel(
                                                title: movieTitleController.text,
                                                director: directorController.text,
                                                poster_url: "https://stat1.bollywoodhungama.in/wp-content/uploads/2016/03/74637391.jpg"
                                            );
                                             Hive.box<DataModel>('moviesBox').putAt(widget.index, mData);
                                            Navigator.pop(context);

                     
      },
      color: MyColors.primaryColor,
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 14.0),
        child: Text("SAVE CHANGES"),
      ),) 
      
            ])
            )
            );
    
  }
}