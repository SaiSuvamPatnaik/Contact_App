import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thirty_days_flutter/Screen/Homepage.dart';

class sign extends StatefulWidget {
  @override
  _signState createState() => _signState();
}

class _signState extends State<sign> {
  @override

  bool _isLoggedIn = false;
  String username,url,mail,fillmail,fillpassword;
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text('Hello',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 185.0, 0.0, 0.0),
                        child: Text('User',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(180.0, 185.0, 0.0, 0.0),
                        child: Text('...',
                            style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      )
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),),
                          style: TextStyle(fontSize: 20),
                          onChanged: (text){
                            fillmail=text;
                          },
                        ),

                        SizedBox(height: 20.0),

                        TextField(
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),),
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          onChanged: (text1){
                            fillpassword=text1;
                          },
                        ),

                        SizedBox(height: 5.0),

                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0),
                          child: InkWell(
                            child: Text(
                              'Forgot Password ???',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),

                        SizedBox(height: 40.0),

                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                if(fillmail=="LIPUN" && fillpassword=="LIPUN"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => homepage(username: "LIPUN",url: "https://trak.in/wp-content/uploads/2020/12/5c93b4a4daa507033b17202a-1024x512-1280x720-1024x576.jpeg",mail:"lipun3434@gmail.com")));
                                }
                                else{
                                  Fluttertoast.showToast(
                                      msg: "ENTER YOUR CORRECT DETAILS TO LOGIN",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              },
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0),

                        Text("OR",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),

                        SizedBox(height: 10.0),

                        Container(
                          height: 40.0,
                          child: Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () {
                                _login();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'LOGIN WITH',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,),
                                  ),
                                  SizedBox(width: 5,),
                                  Image.asset("Assets/Images/google.png"),
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15.0)),
                        ),

                        SizedBox(height: 20,),

                      ],
                    )),

              ],
            ),
          ))
    );
  }

}