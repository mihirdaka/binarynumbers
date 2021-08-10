import 'dart:ffi';
import 'dart:ui';

import 'package:binarynumbers/Auth/login.dart';
import 'package:binarynumbers/Screens/movie_detailed.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

  var postData = [];

  Future<Post> fetchPost() async {
    final response = await http
        .get('http://www.omdbapi.com/?i=tt3896198&apikey=c4033450&s=Movies');

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  callPages(int _page) {
    switch (_selectedIndex) {
      case 0:
        return Container(child: homePage());

      case 1:
        return Container(child: fav());

      case 2:
        return Container(child: bookmark());
    }
  }

  Widget callButtonPages(int _page) {
    switch (_page) {
      case 1:
        return Center(child: Container(child: button1()));
      case 2:
        return Container(child: button2());
      case 3:
        return Container(child: button3());

      default:
        return Container();
    }
  }

  Widget button1() {
    return Center(
      child: Text(
        'This is Movies page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget button2() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 45, 0, 0),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NEW',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(height: 275, child: horizontalList('NEW')),
              SizedBox(
                height: 15,
              ),
              Text(
                'POPULAR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(height: 275, child: horizontalList('POPULAR')),
              SizedBox(
                height: 15,
              ),
              Text(
                'TRENDING',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(height: 275, child: horizontalList('TRENDING')),
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalList(String tag) {
    return new Container(
      height: 275.0,
      child: FutureBuilder<Post>(
        future: post,
        builder: (context, abc) {
          if (abc.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: abc.data!.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Movie_Detail(abc.data!.data[i])));
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: 160,
                            height: 250,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FittedBox(
                                child:
                                    Image.network(abc.data!.data[i]['Poster']),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 237,
                              child: Container(
                                width: 55,
                                height: 26,
                                color: Color.fromRGBO(0, 180, 0, 1),
                                child: Center(
                                    child: Text(
                                  '$tag',
                                  style: TextStyle(
                                      fontSize: tag != 'NEW' ? 11 : 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ))
                        ],
                      ),
                    ),
                  );
                });
          } else if (abc.hasError) {
            return Text("${abc.error}", style: TextStyle(color: Colors.white));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget button3() {
    return Center(
      child: Text(
        'This is Music Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget homePage() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: NetworkImage(
                          'https://pbs.twimg.com/profile_images/1396531437067636737/r0TT66tz_400x400.jpg'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('${_auth.currentUser.displayName ?? 'user'}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 130,
                    height: 40,
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(23, 23, 23, 1))),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          //fontSize: 16
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromRGBO(23, 23, 23, 1),
                      ),
                    ),
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
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: selbutton1
                            ? Color.fromRGBO(242, 0, 74, 0.9)
                            : Colors.transparent,
                        blurRadius: selbutton1 ? 20.0 : 0,
                      ),
                    ]),
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
                        style: TextStyle(
                            color: selbutton1 ? Colors.white : Colors.grey),
                      ),
                    )),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: selbutton2
                            ? Color.fromRGBO(242, 0, 74, 0.9)
                            : Colors.transparent,
                        blurRadius: selbutton2 ? 20.0 : 0,
                      ),
                    ]),
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
                        style: TextStyle(
                            color: selbutton2 ? Colors.white : Colors.grey),
                      ),
                    )),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: selbutton3
                            ? Color.fromRGBO(242, 0, 74, 0.9)
                            : Colors.transparent,
                        blurRadius: selbutton3 ? 20.0 : 0,
                      ),
                    ]),
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
                        style: TextStyle(
                            color: selbutton3 ? Colors.white : Colors.grey),
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
    return Center(
      child: Text(
        'Favourite Tab',
        style: TextStyle(color: Colors.white),

        //style: optionStyle,
      ),
    );
  }

  Widget bookmark() {
    return Center(
      child: Text(
        'Bookmark Tab',
        style: TextStyle(color: Colors.white),

        // style: optionStyle,
      ),
    );
  }

  Widget menu() {
    return Center(
      child: Container(
          child: RaisedButton(
        color: Colors.red,
        onPressed: () {
          _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
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
    if (index == 3) {
      _key.currentState!.openEndDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'BinaryNumbers\nDrawer\n\n-Mihir Daka',
                style: TextStyle(fontSize: 20),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(11, 11, 11, 0.9),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Close'),
              onTap: () {
                Navigator.pop(context);
                //_key.currentState!.();
              },
            )
          ],
        ),
      ),
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
        currentIndex: _selectedIndex,
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
  final data;

  Post({required this.data});

  factory Post.fromJson(Map<String, dynamic> json) {
    print(json['Search']);
    return Post(
      data: json['Search'],
    );
  }
}
