import 'package:binarynumbers/Screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //login key
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  //Variables
  bool _hidePassword = true;
  bool isLoading = false;
  bool distributorchecked = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      user.updateProfile(displayName:_name.text);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch  (e) {
      setState(() {
        isLoading=false;
      });
      print("[SignIn] : $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message,style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,));

      return null;
    }
  }
  //Connect the backend Firebase

  //Text Input field initisalized
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _name = TextEditingController();

  TextEditingController _password = TextEditingController();
  Signup() async {
    if (_loginKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      signUpWithEmailAndPassword(_emailAddress.text, _password.text);
    }
  }

  String passwordValidator(String value) {
    if (value.length < 6) {
      return 'Password is too short';
    } else {
      return '';
    }
  }

  //Password Peek function
  passwordPeak() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.0,
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.blueGrey,
                  child: Text("Logo here"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Signup",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                Form(
                  key: _loginKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                            validator: (value) {
                            if (value!.length < 3) {
                              return 'Name is too short';
                            } else {
                              return null;
                            }
                          },
                           controller: _name,
                          //validator: emailValidator,
                          keyboardType: TextInputType.name,
                            style: TextStyle(color: Colors.black87),

                          decoration: InputDecoration(
                              
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black26,
                              ),
                              
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.black26),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                            style: TextStyle(color: Colors.black87),

                          controller: _emailAddress,
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value!)) {
                              return 'Email format is invalid';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black26,
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black26),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                            style: TextStyle(color: Colors.black87),

                          controller: _password,
                          validator: (value) {
                            if (value!.length < 7) {
                              return 'Password is too short';
                            } else {
                              return null;
                            }
                          },
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black26,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                color:
                                    _hidePassword ? Colors.black26 : Colors.red,
                                onPressed: () {
                                  passwordPeak();
                                },
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      InkWell(
                        onTap: () {
                          Signup();
                        },
                        child: Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          //margin: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Center(
                            child: isLoading?CircularProgressIndicator(color: Colors.white):Text("Signup",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already registered?",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
                Divider(),
              ],
            )
          ],
        ),
      )),
    );
  }
}
