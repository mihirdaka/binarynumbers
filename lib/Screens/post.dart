import 'dart:async';  
import 'dart:convert';  
  
import 'package:flutter/material.dart';  
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;  

  
class Rest extends StatefulWidget {  
  Rest({ Key? key}) : super(key: key);  
  
  @override  
  _RestState createState() => _RestState();  
}  
  
class _RestState extends State<Rest> {  
late Future<Post> post;  

  @override  
  void initState() {  
    super.initState();  
    post = fetchPost();  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'Flutter REST API Example',  
      theme: ThemeData(  
        primarySwatch: Colors.green,  
      ),  
      home: Scaffold(  
        appBar: AppBar(  
          title: Text('Flutter REST API Example'),  
        ),  
        body: Center(  
          child: FutureBuilder<Post>(  
            future: post,  
            builder: (context, abc) {  
              if (abc.hasData) {  
                return Text(abc.data!.title);  
              } else if (abc.hasError) {  
                return Text("${abc.error}");  
              }  
  
              // By default, it show a loading spinner.  
              return CircularProgressIndicator();  
            },  
          ),  
        ),  
      ),  
    );  
  }  
}  
  
Future<Post> fetchPost() async {  
  final response = await http.get('http://www.omdbapi.com/?i=tt3896198&apikey=c4033450&s=Movies');  
  
  if (response.statusCode == 200) {  
    // If the call to the server was successful (returns OK), parse the JSON.  
    // print(response.body);
    // json = response.body;
     
    return Post.fromJson(json.decode(response.body));  
   
  } else {  
    // If that call was not successful (response was unexpected), it throw an error.  
    throw Exception('Failed to load post');  
  }  
}  
  
class Post {  
  final String userId;  
  
  final String title;  
  final String description;  
  
  Post({required this.userId, required this.title, required this.description});  
  
  factory Post.fromJson(Map<String, dynamic> json) {  
    
    return Post(  
      
      userId: json['Search'][0]['Year'],
      title: json['Search'][0]['Poster'],  
      description: json['Search'][0]['Type'],  
    );  
  }  
}  