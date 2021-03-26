import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thirty_days_flutter/Screen/contacts.dart';
import 'package:flutter/cupertino.dart';

class Edit extends StatefulWidget {

  String contactkey,username;
  Edit({
    this.contactkey,
    this.username
});
  @override
  _EditState createState() => _EditState(username:username);
}

class _EditState extends State<Edit> {
  String username;
  _EditState({
    this.username
  });
  TextEditingController namecontroller,numbercontroller;
  String typeselected;

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

  DatabaseReference ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller=TextEditingController();
    numbercontroller=TextEditingController();
    ref = FirebaseDatabase.instance.reference().child(username).child("Contact");
    getcontact();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                controller: namecontroller,
                style: TextStyle(fontSize: 20,color: Colors.black),
                decoration: InputDecoration(

                  labelText: ("Enter Name"),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person,size: 30,color: Colors.blueAccent,),
                  filled: true,
                ),


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
                      child: Text("Update Contact",style: TextStyle(color: Colors.white,fontSize: 18),),
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
                            MaterialPageRoute(builder: (context) => contacts()));
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

  void getcontact() async{
    DataSnapshot Snapshot = await ref.child(widget.contactkey).once();
    Map contact = Snapshot.value;
    namecontroller.text = contact["Name"];
    numbercontroller.text=contact["Phone"];
    setState(() {
      typeselected=contact["Title"];
    });
}
  void savecontact() {
    String name = namecontroller.text;
    String number = numbercontroller.text;
    Map<String,String> contact = {
      "Name":name,
      "Phone":number,
      "Title":typeselected,
    };
    ref.child(widget.contactkey).update(contact).then((value) => Navigator.pop(context));
  }



}
