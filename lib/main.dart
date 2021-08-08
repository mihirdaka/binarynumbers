import 'package:binarynumbers/Auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Auth/login.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    //  title: 'Flutter Demo',
      
      theme: ThemeData(
        brightness: Brightness.dark,
       
      ),
      home: MyHomePage(title: 'Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? isUserLoggedIn;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isUserLoggedIn = true;
      print(user.email);
    } else {
      isUserLoggedIn = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BinaryNumbers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "ProductSans"),
      home: isUserLoggedIn != null
          ? isUserLoggedIn == true? 
          HomePage()
          :LoginPage()
          : Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator())),
      //home:
      //home: AdminPanel(),
    );
  }
}
