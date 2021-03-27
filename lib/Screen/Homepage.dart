import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thirty_days_flutter/Screen/Edit.dart';
import 'package:thirty_days_flutter/Screen/add_contacts.dart';
import 'package:thirty_days_flutter/Screen/contacts.dart';
import 'package:thirty_days_flutter/Screen/history.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';

class homepage extends StatefulWidget {
  String username,url,mail;
  homepage({
    this.username,
    this.url,
    this.mail
  });

  @override
  _homepageState createState() => _homepageState(username:username,url:url,mail:mail);
}

class _homepageState extends State<homepage> {
  String username,url,mail;
  _homepageState({
    this.username,
    this.url,
    this.mail
  });
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn = true;
  DatabaseReference ref;
  String Acc,name="";
  String balance="";
  String url1;
  bool tapped=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.reference().child("User").child(username);
    getacc();
    Timer(Duration(seconds: 1),()=>
        showToast());
  }
  showToast(){
    if(balance=="") {
      Fluttertoast.showToast(
          msg: "$username, Click on refill to add amount to your wallet",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  void getacc() async{
    DataSnapshot Snapshot = await ref.once();
    Map acc = Snapshot.value;
    setState(() {
      balance=acc["Balance"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Welcome $username",style: TextStyle(fontSize: 20),),

        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => history(username:username)));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(backgroundImage:  NetworkImage("$url")),
                title: Text("$username"),
                subtitle: Text("$mail"),
              ),
              ListTile(leading: Icon(Icons.home), title: Text("Home"),onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => homepage(username:username,url:url,mail:mail)));},),
              ListTile(leading: Icon(Icons.contact_phone), title: Text("Add Contact"),onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddContacts(username:username,url:url,mail:mail)));}),
              ListTile(leading: Icon(Icons.contacts), title: Text("Check Contact"),onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => contacts(username:username)));}),
              ListTile(leading: Icon(Icons.edit), title: Text("Edit Contact"),onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Edit(username:username,url:url,mail:mail)));}),
              ListTile(leading: Icon(Icons.history), title: Text("Transaction History"),onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => history(username:username,url:url,mail:mail)));}),
              ListTile(leading: Icon(Icons.logout),
                  title: Text("Log Out"),onTap: (){
                    _googleSignIn.signOut();
                  setState(() {
                    _isLoggedIn = false;
                  });
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => sign()));
              }),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,0),
              child: Image.asset("Assets/Images/Hey.png"),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text("User Details",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.redAccent,
                  ),),
            ),
            SizedBox(height: 5,),
            Center(
              child: Container(
                height: 235,
                width: 370,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  color: Color(0xFF002366),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,25,0,0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code_scanner_outlined,color: Colors.white,size: 30,),
                            SizedBox(width: 10,),
                            Text("4580 9876 6521 3456",style: TextStyle(color: Colors.white,fontSize: 25),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,15,0,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_add,color: Colors.white,size: 30,),
                            SizedBox(width: 10,),
                            Text("$username",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.verified_user,color: Colors.white,size: 30,),
                          SizedBox(width: 15,),
                          Text("Your Balance :-",style: TextStyle(color: Colors.white,fontSize: 25),),
                          SizedBox(width: 10,),

                          Text("$balance",style: TextStyle(color: Colors.white,fontSize: 25),),

                        ],
                      ),
                      SizedBox(height: 30,),


                    ],
                  ),
                ),

              ),

            ),
            SizedBox(height: 10,),
            Center(
              child: InkWell(
                onTap: ()async{
                  setState(() {
                    tapped=true;
                    balance="10000";
                  });
                  Map<String,String> refill={
                    "Balance":"10000",
                  };
                  ref.update(refill).then((value) => Fluttertoast.showToast(
                      msg: "Refilled Amount Of Rs 10000",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  ));
                  await Future.delayed(Duration(milliseconds: 2000));
                  setState(() {
                    tapped=false;
                  });

                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 50,
                  width: tapped? 50:95,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: tapped
                      ?Icon(Icons.done,color: Colors.white,)
                      :Center(child: Text("REFILL",style: TextStyle(fontSize: 18,color: Colors.white),)),
                ),
              ),
            )

          ]),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContacts(username:username,url:url,mail:mail)));
        },
        child: Icon(Icons.add,color: Colors.white,size: 20,),

      ),
    );
  }

}
