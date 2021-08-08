import 'package:binarynumbers/Auth/signup.dart';
import 'package:binarynumbers/Screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //login key
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  //Variables
  bool _hidePassword = true;
  bool isLoading = false;
  bool distributorchecked = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      print("[SignIn] : $e");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));

      return null;
    }
  }
  //Connect the backend Firebase

  //final snackBar = SnackBar(content: Text(error,style: TextStyle(color: Colors.red),),backgroundColor: Colors.white,);

  //Text Input field initisalized
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _password = TextEditingController();
  logIn() async {
    if (_loginKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      signInWithEmailAndPassword(_emailAddress.text, _password.text);
    }
  }

  //Validation for the textform fields
  String? emailValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
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
        body: SafeArea(
          child: Container(
              // color: Colors.black,
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
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
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
                            controller: _emailAddress,
                            //validator: emailValidator,
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
                            controller: _password,
                            //  validator: passwordValidator,
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black26,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  color: _hidePassword
                                      ? Colors.black26
                                      : Colors.blue,
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
                            logIn();
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
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text("Login",
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
                        "Are you a new customer?",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 15),
                          ))
                    ],
                  ),
                  Divider(),
                ],
              )
            ],
          )),
        ));
  }
}
