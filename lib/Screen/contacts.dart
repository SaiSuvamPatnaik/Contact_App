import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_flutter/Screen/Edit.dart';
import 'package:thirty_days_flutter/Screen/Homepage.dart';

import 'package:thirty_days_flutter/Screen/add_contacts.dart';
import 'package:thirty_days_flutter/Screen/history.dart';
import 'package:thirty_days_flutter/main.dart';

class contacts extends StatefulWidget {
  @override
  _contactsState createState() => _contactsState();
}

class _contactsState extends State<contacts> {

  Query ref;
  DatabaseReference ref1,ref2,ref3;
  String addamount,balanceamount,newkey;
  int newamount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref=FirebaseDatabase.instance.reference().child("Contact").orderByChild("Name");
    ref1 = FirebaseDatabase.instance.reference().child("Contact");
    ref2 = FirebaseDatabase.instance.reference().child("Transactions");
    ref3 = FirebaseDatabase.instance.reference().child("User").child("Sai Suvam");
  }

  Widget buildcontactitems({Map contact, int pos}){

    return Padding(
      padding: const EdgeInsets.fromLTRB(15,10,15,0),
      child: Container(
        height: 200,
        color: Colors.white,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.person,color: Colors.blueAccent,size: 30,),
                SizedBox(width: 10,),
                Text(contact["Name"],style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.w600),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.phone_android_rounded,color: Colors.blueAccent,size: 30,),
                SizedBox(width: 5,),
                Text("+91-"+contact["Phone"],style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.w600),),
                SizedBox(width: 35,),
                Icon(Icons.group_work,color: gettypecolor(contact["Title"]),size: 30,),
                SizedBox(width: 5,),
                Text(contact["Title"],style: TextStyle(fontSize: 20,color: gettypecolor(contact["Title"]),fontWeight: FontWeight.w600),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.account_balance,color: Colors.blueAccent,size: 30,),
                SizedBox(width: 5,),
                Text(" Rs- "+contact["Balance"],style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.w600),),
                SizedBox(width: 35,),
              ],
            ),
            SizedBox(height: 10,),

            Row(
              children: [
                SizedBox(width: 20,),
                RaisedButton.icon(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Edit(contactkey: contact["key"],)));
                },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  icon: Icon(Icons.edit,size: 20,),
                  label: Text("Edit",style: TextStyle(fontSize: 15,color: Colors.black),),),

                SizedBox(width: 15,),

                RaisedButton.icon(onPressed: (){
                  ref1.child(contact["key"]).remove();

                },
                  icon: Icon(Icons.delete,size: 20,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: Text("Delete",style: TextStyle(fontSize: 15,color: Colors.black),),),
                SizedBox(width: 20,),
                RaisedButton.icon(onPressed: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text("Transfer Money To ${contact["Name"]}"),
                      content: TextField(


                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.money_outlined,size: 25,)
                        ),
                        onChanged: (text){
                          addamount=text;
                        },
                        style: TextStyle(fontSize: 25,color: Colors.black),
                      ),
                      actions: [
                        FlatButton(onPressed: (){
                          balanceamount = contact["Balance"];
                          newamount=int.parse(balanceamount)+int.parse(addamount);
                          DateTime now = new DateTime.now();
                          Map<String,String> edited={
                            "Balance":newamount.toString(),
                          };
                          Map<String,String> transaction={
                            "Name":contact["Name"],
                            "Amount":addamount,
                            "Day":now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
                            "Time":now.hour.toString()+":"+now.minute.toString()+":"+now.second.toString(),
                          };
                          ref1.child(contact["key"]).update(edited).then((value) => Navigator.pop(context));
                          newkey = ref2.push().key;
                          ref2.push().set(transaction);
                          getacc(addamount);

                        },
                          child: Text("OK",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),),


                      ],
                    );
                  });
                },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  icon: Icon(Icons.money,size: 20,),
                  label: Text("Transfer",style: TextStyle(fontSize: 15,color: Colors.black),),),
              ],
            ),


          ],
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Contacts"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.backspace,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homepage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => history()));
            },
          )
        ],

      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(query: ref ,itemBuilder: (BuildContext context,
            DataSnapshot snapshot,Animation<double>animation,int index){
          Map contact = snapshot.value;
          contact["key"] = snapshot.key;
          return buildcontactitems(contact: contact,pos: index);
        },),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContacts()));
        },
        child: Icon(Icons.add,color: Colors.white,size: 20,),

      ),
    );
  }

  getacc(String addamount) async{
    DataSnapshot Snapshot = await ref3.once();
    Map acc = Snapshot.value;
    int myamount = int.parse(acc["Balance"])-int.parse(addamount);
    Map<String,String> acct = {
      "Balance":myamount.toString(),
    };
    ref3.update(acct);
  }
  Color gettypecolor(String type){
    Color color = new Color(1);                //Creating Object of the class Color

    if(type=="Work")
      color=Colors.brown;

    if(type=="Official")
      color=Colors.orange;

    if(type=="Friends")
      color=Colors.teal;

    if(type=="Family")
      color=Colors.cyan;

    if(type=="Other")
      color=Colors.green;

    return color;
  }
}