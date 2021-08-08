import 'dart:ffi';
import 'dart:ui';

import 'package:binarynumbers/Auth/login.dart';
import 'package:binarynumbers/Screens/post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;  
import 'dart:async';  
import 'dart:convert';
import 'model.dart';
import 'package:http/http.dart';  
  


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selbutton1 = false;
  bool selbutton2 = true;
  bool selbutton3 = false;
  int selectedButton = 2;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Color selectedButtoncolor = Color.fromRGBO(242, 0, 74, 1);



  

late Future<Post> post;  

  @override  
  void initState() {  
    super.initState();  
    
    post = fetchPost();  
  }  
  var postData =[];


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
  
  

  // TabController _tabController = TabController(length: 2);
  Widget callPages(int _page) {
    switch (_selectedIndex) {
      case 0:
        return Container(child: homePage());

      case 1:
        return Container(child: fav());

      case 2:
        return Container(child: bookmark());
      case 3:
        return Container(child: menu());

      default:
        return Container();
    }
  }

  Widget callButtonPages(int _page) {
    switch (_page) {
      case 1:
        return Container(child: button1());
      case 2:
        return Container(child: button2());
      case 3:
        return Container(child: button3());

      default:
        return Container();
    }
  }

  Widget button1() {
    print('hehe');
    return Text(
      'Movies',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget button2() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NEW',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(height: 300, child: horizontalList1),
              Text(
                'POPULAR',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Center(  
              child: FutureBuilder<Post>(  
                future: post,  
                builder: (context, abc) {  
                  if (abc.hasData) {  
                    return   Stack(
              alignment: Alignment.center,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  elevation: 5,
                  child: Container(
                    width: 150.0,
                    color: Colors.red,
                    child: Image.network(abc.data!.title),
                  ),
                ),
                Positioned(
                    top: 235,
                    child: Container(
                      width: 65,
                      height: 23,
                      color: Color.fromRGBO(2, 222, 22, 1),
                      child: Center(
                          child: Text(
                        'NEW',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ))
              ],
            );
                  } else if (abc.hasError) {  
                    return Text("${abc.error}",style: TextStyle(
                    color: Colors.white));
                  }  
          
                  // By default, it show a loading spinner.  
                  return CircularProgressIndicator();  
                },  
              ),  
            ),  
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalList1 = new Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 220.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                elevation: 5,
                child: Container(
                  width: 150.0,
                  color: Colors.red,
                ),
              ),
              Positioned(
                  top: 235,
                  child: Container(
                    width: 65,
                    height: 23,
                    color: Color.fromRGBO(2, 222, 22, 1),
                    child: Center(
                        child: Text(
                      'NEW',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                  ))
            ],
          ),
          SizedBox(
            width: 10,
          ),
             Stack(
            alignment: Alignment.center,
            children: [
              Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                elevation: 5,
                child: Container(
                  width: 150.0,
                  color: Colors.red,
                ),
              ),
              Positioned(
                  top: 235,
                  child: Container(
                    width: 65,
                    height: 23,
                    color: Color.fromRGBO(2, 222, 22, 1),
                    child: Center(
                        child: Text(
                      'NEW',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                  ))
            ],
          ),
          Container(
            width: 160.0,
            color: Colors.orange,
          ),
          Container(
            width: 160.0,
            color: Colors.pink,
          ),
          Container(
            width: 160.0,
            color: Colors.yellow,
          ),
        ],
      ));
  Widget button3() {
    return Text(
      'Music',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget homePage() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: NetworkImage(
                        'https://pbs.twimg.com/profile_images/1396531437067636737/r0TT66tz_400x400.jpg'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Mihir Daka',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ]),
                Container(
                  width: 100,
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(23, 23, 23, 1),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: selbutton1 ? 45 : 35,
                    width: selbutton1 ? 120 : 90,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      color: selbutton1
                          ? Color.fromRGBO(242, 0, 74, 1)
                          : Color.fromRGBO(23, 23, 23, 1),
                      onPressed: () {
                        // FirebaseAuth.instance.signOut();
                        setState(() {
                          selectedButton = 1;
                          selbutton1 = true;
                          selbutton2 = false;
                          selbutton3 = false;
                        });
                      },
                      child: Text(
                        'Movies',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Container(
                    height: selbutton2 ? 45 : 35,
                    width: selbutton2 ? 120 : 90,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      color: selbutton2
                          ? Color.fromRGBO(242, 0, 74, 1)
                          : Color.fromRGBO(23, 23, 23, 1),
                      onPressed: () {
                        // FirebaseAuth.instance.signOut();
                        setState(() {
                          selectedButton = 2;

                          selbutton2 = true;
                          selbutton1 = false;
                          selbutton3 = false;
                        });
                      },
                      child: Text(
                        'Shows',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Container(
                    height: selbutton3 ? 45 : 35,
                    width: selbutton3 ? 120 : 90,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      color: selbutton3
                          ? Color.fromRGBO(242, 0, 74, 1)
                          : Color.fromRGBO(23, 23, 23, 1),
                      onPressed: () {
                        // FirebaseAuth.instance.signOut();
                        setState(() {
                          selectedButton = 3;

                          selbutton3 = true;
                          selbutton2 = false;
                          selbutton1 = false;
                        });
                      },
                      child: Text(
                        'Music',
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
            Container(
              //color: Colors.white,
              child: callButtonPages(selectedButton),
            )
          ],
        ),
      ),
    );
  }

  Widget fav() {
    return Text(
      'Index 1: Business',
      style: TextStyle(color: Colors.white),

      //style: optionStyle,
    );
  }

  Widget bookmark() {
    return Text(
      'Index 2: School',
      style: TextStyle(color: Colors.white),

      // style: optionStyle,
    );
  }

  Widget menu() {
    return Center(
      child: Container(
          child: RaisedButton(
        color: Colors.red,
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Rest()));
        },
        child: Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //   currentIndex: _selectedIndex,

        showSelectedLabels: false,
        showUnselectedLabels: false,
        //fixedColor: Colors.black,
        backgroundColor: Color.fromRGBO(23, 23, 23, 0.5),
        selectedItemColor: Color.fromRGBO(242, 0, 74, 1),
        unselectedItemColor: Color.fromRGBO(64, 64, 64, 1),
        iconSize: 30,
        currentIndex:
            _selectedIndex, // this will be set when a new tab is tapped
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text(
              'Home',
              style: TextStyle(color: Color.fromRGBO(242, 0, 74, 1)),
            ),
            backgroundColor: Color.fromRGBO(23, 23, 23, 0.5),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.star),
            title: new Text('Favourite',
                style: TextStyle(color: Color.fromRGBO(242, 0, 74, 1))),
            backgroundColor: Color.fromRGBO(23, 23, 23, 0.5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('bookmark',
                style: TextStyle(color: Color.fromRGBO(242, 0, 74, 1))),
            backgroundColor: Color.fromRGBO(23, 23, 23, 0.5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('Menu',
                style: TextStyle(color: Color.fromRGBO(242, 0, 74, 1))),
            backgroundColor: Color.fromRGBO(23, 23, 23, 0.5),
          ),
        ],

        onTap: _onItemTapped,
      ),
      body: Center(
        child: callPages(_selectedIndex),
      ),
    );
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