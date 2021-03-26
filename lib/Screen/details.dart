import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class details extends StatefulWidget {
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  bool _isLoggedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_googleSignIn.currentUser.displayName),
          OutlineButton( child: Text("Logout"), onPressed: (){
            _logout();
          },)
        ],
      ),

    );
  }
}
