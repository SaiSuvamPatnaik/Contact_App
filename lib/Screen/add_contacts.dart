import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thirty_days_flutter/Screen/contacts.dart';

import 'Homepage.dart';

class AddContacts extends StatefulWidget {
  String username,url,mail;
  AddContacts({
    this.username,
    this.url,
    this.mail
  });
  @override
  _AddContactsState createState() => _AddContactsState(username:username,url:url,mail:mail);
}

class _AddContactsState extends State<AddContacts> {

  String username,url,mail;
  _AddContactsState({
    this.username,
    this.url,
    this.mail
  });
  TextEditingController numbercontroller;
  String typeselected,nameadd;
  DatabaseReference ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numbercontroller=TextEditingController();
    ref = FirebaseDatabase.instance.reference().child("Contact").child(username);
  }

  Widget ButtonType(String title){
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,0,0,0),
        child: RaisedButton(
          color: Colors.redAccent,
          elevation: 5,
          onPressed: (){
            setState(() {
              typeselected=title;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),

          ),
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Text(title,style: TextStyle(fontSize: 20,color: Colors.white),),
          ),
        ),
      ),

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homepage(username:username,url:url,mail:mail)));
          },
        ),
        title: Text("Add Contact"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20,40,20,0),
              child: TextField(

                style: TextStyle(fontSize: 20,color: Colors.black),
                decoration: InputDecoration(

                  labelText: ("Enter Name"),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person,size: 30,color: Colors.blueAccent,),
                  filled: true,
                ),
                onChanged: (name){
                  nameadd=name;
                },


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20,20,20,0),
              child: Container(
                child: TextField(
                  controller: numbercontroller,
                  style: TextStyle(fontSize: 20,color: Colors.black),
                  decoration: InputDecoration(

                    labelText: ("Enter Phone Number"),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone_android,size: 30,color: Colors.blueAccent,),
                    filled: true,
                  ),

                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ButtonType("Work"),

                    ButtonType("Official"),

                    ButtonType("Friends"),

                    ButtonType("Family"),
                    ButtonType("Others"),
                    SizedBox(width: 25,),


                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,0,30,0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0,15,0,15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),

                      ),

                      color: Colors.blueAccent,
                      onPressed: (){
                        savecontact();
                      },
                      child: Text("Add To Contact",style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,0,30,0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0,15,0,15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),

                      ),

                      color: Colors.blueAccent,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => contacts(username:username,url:url,mail:mail)));
                      },
                      child: Text("Check Contact",style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
  void savecontact() {
    String number = numbercontroller.text;
    Map<String,String> contact = {
      "Name":nameadd,
      "Phone":number,
      "Title":typeselected,
      "Balance":"10000",
    };
    ref.push().set(contact);
  }

}

