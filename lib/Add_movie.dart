import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app_hive/Theme/theme.dart';
import 'package:movies_app_hive/movie_model.dart';
import 'package:hive/hive.dart';


class AddMovie extends StatefulWidget {
  const AddMovie({ Key? key }) : super(key: key);

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  
  
  String imgBase64 = "";

 late File? _file = null;

  Future getImage() async{
    final ImagePicker _picker = ImagePicker();
  XFile?_image = await _picker.pickImage(source: ImageSource.gallery);
   setState(() {
     print("inside setstate");
     _file = File(_image!.path);
     imgBase64 = generateBytes(_file!) as String;
     print("imgBase64 generated "+imgBase64);
   }); 
   
  }

  Future<String> generateBytes(File image) async{
    print("inside generateBytes");
    final bytes = image.readAsBytesSync();
    // String base64Encode(List<int> bytes) => base64.encode(bytes);
     return convert(bytes);
    
  }
  Future<String> convert(bytes) async{
    print("inside convert");

    return base64Encode(bytes);
    
  }

  TextEditingController movieTitleController = TextEditingController();
  TextEditingController directorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        automaticallyImplyLeading: true,
        title: Text("ADD NEW MOVIE"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: getImage,
                  child: Container(
                    height: 140,
                    width: 140,
                    color: MyColors.primaryColorLight,
                    child: _file ==null?Icon(Icons.camera_alt_rounded,
                    size: 50,):Image.file(_file!)
                  ),
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

      RaisedButton(onPressed: (){


        final String title = movieTitleController.text;
                      final String director = directorController.text;
                      movieTitleController.clear();
                      directorController.clear();
                      DataModel data = DataModel(title: title, director: director, poster_url: imgBase64);
                      print("image in bytes"+imgBase64);
                      Hive.box<DataModel>('moviesBox').add(data);
                      Navigator.pop(context);
      },
      color: MyColors.primaryColor,
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 14.0),
        child: Text("ADD MOVIE"),
      ),) 
      
            ])
            )
            );
  }
}