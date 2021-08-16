import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app_hive/Theme/theme.dart';
import 'package:image_picker/image_picker.dart';
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
  String imgBase64 = "";

 late File? _file = null;

  Future getImage() async{
    final ImagePicker _picker = ImagePicker();
  XFile?_image = await _picker.pickImage(source: ImageSource.gallery);
   setState(() async{
     print("inside setstate");
     _file = File(_image!.path);
     // ignore: unnecessary_cast
     imgBase64 = await generateBytes(_file!) as String;
     print("imgBase64 generated "+imgBase64);
   }); 
   
  }

  Future<String> generateBytes(File image) async{
    print("inside generateBytes");
    final bytes = image.readAsBytesSync();
    print("Converted bytes"+ bytes.toString());
    // String base64Encode(List<int> bytes) => base64.encode(bytes);
     return await convert(bytes);
    
  }
  Future<String> convert(bytes) async{
    print("inside convert");

    imgBase64=base64Encode(bytes);
    print(imgBase64.toString());
    return imgBase64;

    
  }

  
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
                child: GestureDetector(
                  onTap: getImage ,
                  child: Container(
                    height: 140,
                    width: 140,
                    color: MyColors.primaryColorLight,
                    child: imgBase64 ==""?Icon(Icons.camera_alt_rounded,
                    size: 50,):Image.memory(base64Decode(imgBase64))
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

      RaisedButton(
        onPressed: (){
          DataModel mData = DataModel(
                                                title: movieTitleController.text,
                                                director: directorController.text,
                                                poster_url: imgBase64
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