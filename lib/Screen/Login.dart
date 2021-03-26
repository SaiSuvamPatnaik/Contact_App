import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thirty_days_flutter/Screen/Homepage.dart';


class sign extends StatefulWidget {
  @override
  _signState createState() => _signState();
}

class _signState extends State<sign> {
  @override

  bool _isLoggedIn = false;
  String username,url,mail;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
        username = _googleSignIn.currentUser.displayName;
        url = _googleSignIn.currentUser.photoUrl;
        mail = _googleSignIn.currentUser.email;
      });
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homepage(username: username,url: url,mail:mail)));
    } catch (err){
      print(err);
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Center(
              child: OutlineButton(
                child: Text("Login with Google"),
                onPressed: () {
                  _login();
                },
              ),
            )),
      ),
    );
  }

}
