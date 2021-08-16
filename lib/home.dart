import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app_hive/Add_movie.dart';
import 'package:movies_app_hive/Edit_Details.dart';
import 'package:movies_app_hive/Theme/theme.dart';
import 'package:movies_app_hive/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.primaryColor,
      title: Text("My Watchlist"),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
  onPressed: (){
   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddMovie()),
  );
  },
  child: Icon(Icons.add),
),

body:  

SingleChildScrollView(
  child:   Column(
  
    children: [
      
     
  
          FutureBuilder(
        future: Hive.openBox<DataModel>("moviesBox"),
        builder: (context, snapshot) {
          while(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          return     ValueListenableBuilder(
            valueListenable: Hive.box<DataModel>('moviesBox').listenable(),
            builder: (context, Box<DataModel> items, _){
              List<int> keys= items.keys.cast<int>().toList();
              return ListView.builder(
                itemCount: keys.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:(_, index){
                  final int key = keys[index];
                  final DataModel? data = items.get(key);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                    child: Card(
                      elevation: 3,
                      shadowColor: MyColors.primaryColorLight,
                      child: ListTile(
                        onTap:(){
                           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditMovie(index:index,)),
  );
                        } ,
                        title: Text(data!.title),
                        subtitle: Text(data.director),
                        leading:  Container(
                  width: 120,
                  height: 140,
                  child: Image(
                    fit: BoxFit.contain,
                  image: NetworkImage("https://stat1.bollywoodhungama.in/wp-content/uploads/2016/03/74637391.jpg"),
                ),),
                        trailing: InkWell(
                          onTap: (){
                            showDialog(
				context: context,
				builder: (BuildContext context) {
					return Expanded(
					child: AlertDialog(
						title: Text('Delete?'),
						content: Text('Are you sure you want to remove the item from the list?'),
						actions: [
						FlatButton(
							textColor: Colors.black,
							onPressed: () {

                    Navigator.pop(context);
              },
							child: Text('CANCEL'),
						),
						FlatButton(
							textColor: Colors.black,
							onPressed: () {
                Hive.box<DataModel>('moviesBox').delete(keys[index]);
                Navigator.pop(context);
              },
							child: Text('DELETE'),
						),
						],
					),

					);
				},
				);


                          },
                          child: Icon(
                            Icons.delete,color: MyColors.primaryColorLight,)
                            ),

                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      ),
  
    ],
  
  ),
),
      
    );
  }
}