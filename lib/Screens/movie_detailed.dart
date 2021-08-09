import 'package:flutter/material.dart';

// ignore: camel_case_types
class Movie_Detail extends StatefulWidget {
  final data;
  Movie_Detail(this.data);
  @override
  _Movie_DetailState createState() => _Movie_DetailState(this.data);
}

// ignore: camel_case_types
class _Movie_DetailState extends State<Movie_Detail> {
  final data;
  _Movie_DetailState(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(22, 22, 22,1),
        title: Text('Movie Detail'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 400,
                width: MediaQuery.of(context).size.width-50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: FittedBox(
                    child: Image.network(data['Poster']),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: Text(data['Title'],textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
               Container(
                padding: EdgeInsets.all(0),
                child: Text('${data['Type']}', style: TextStyle(color: Colors.white,fontSize: 18),)),
           
              Container(
                padding: EdgeInsets.all(10),
                child: Text('(${data['Year']})', style: TextStyle(color: Colors.white,fontSize: 20),)),
           Container(
                padding: EdgeInsets.all(0),
                child: Text('IMDB : ${data['imdbID']}', style: TextStyle(color: Colors.white,fontSize: 15),)),
           
            ]
            ,
          ),
        ),
      ),
    );
  }
}
