import 'package:hive/hive.dart';

 part 'movie_model.g.dart';

@HiveType(typeId: 0)
class DataModel{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String director;
  @HiveField(2)
  final String poster_url;

  DataModel({required this.title, required this.director, required this.poster_url});

}