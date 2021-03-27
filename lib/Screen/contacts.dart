import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_flutter/Screen/Edit.dart';
import 'package:thirty_days_flutter/Screen/Homepage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thirty_days_flutter/Screen/add_contacts.dart';
import 'package:thirty_days_flutter/Screen/history.dart';

//

class contacts extends StatefulWidget {
  String username,url,mail;
  contacts({
    this.username,
    this.url,
    this.mail
  });
  @override
  _contactsState createState() => _contactsState(username:username,url:url,mail:mail);
}

class _contactsState extends State<contacts> {
  final razorpay = Razorpay();
  String username,url,mail,minebalance,userbalance,userskey;
  _contactsState({
    this.username,
    this.url,
    this.mail
  });
  Query ref;
  DatabaseReference ref1,ref2,ref3,ref4;
  String addamount,balanceamount,newkey,balance;
  int newamount;
  String deletekey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,paysucess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,payfailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,payexternal);
    ref=FirebaseDatabase.instance.reference().child("Contact").child(username).orderByChild("Name");
    ref1 = FirebaseDatabase.instance.reference().child("Contact").child(username);
    ref2 = FirebaseDatabase.instance.reference().child("Transactions").child(username);
    ref3 = FirebaseDatabase.instance.reference().child("User").child(username);
    getaccdetails();

  }
  void paysucess(PaymentSuccessResponse response){
    Fluttertoast.showToast(
        msg: "Rs $addamount Sucessfully transfered",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void payfailure(PaymentFailureResponse response){
    ref2.child("$deletekey").remove();
    updatemine();
    updateusers();
    Fluttertoast.showToast(
        msg: "Payment Of Rs $addamount Failed...Try Again Later",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  updatemine() async{
    DataSnapshot Snapshot = await ref3.once();
    Map mine = Snapshot.value;
    minebalance=mine["Balance"];
    int updation1=int.parse(minebalance)+int.parse(addamount);
    Map<String,String> change1={
      "Balance":updation1.toString()
    };
    ref3.update(change1);
  }
  updateusers() async{
    DataSnapshot Snapshot = await ref1.child("$userskey").once();
    Map users = Snapshot.value;
    userbalance=users["Balance"];
    int updation=int.parse(userbalance)-int.parse(addamount);
    Map<String,String> change={
      "Balance":updation.toString()
    };
    ref1.child("$userskey").update(change);
  }
  void payexternal(ExternalWalletResponse response){

  }

  void getpayment(String addamount){
    var option = {
      'key':'rzp_test_YihQ2nqrabwrFH',
      'amount': int.parse(addamount)*100,
      'name':'SAI SUVAM',
      'prefill':{'contact':'6370001439','email':'lipun3434@gmail.com'}
    };
    razorpay.open(option);
  }
  void getaccdetails() async{

    DataSnapshot Snapshot = await ref3.once();
    Map acc = Snapshot.value;
    setState(() {
      balance=acc["Balance"];
    });
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
                      MaterialPageRoute(builder: (context) => Edit(contactkey: contact["key"],username:username,url:url,mail:mail)));
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
                          setState(() {
                            addamount=text;
                          });
                        },
                        style: TextStyle(fontSize: 25,color: Colors.black),
                      ),
                      actions: [
                        FlatButton(onPressed: (){
                          getpayment(addamount);
                          if(int.parse(balance)>=int.parse(addamount)) {
                            balanceamount = contact["Balance"];
                            newamount = int.parse(balanceamount) + int.parse(addamount);
                            DateTime now = new DateTime.now();
                            Map<String, String> edited = {
                              "Balance": newamount.toString(),
                            };
                            Map<String, String> transaction = {
                              "Name": contact["Name"],
                              "Amount": addamount,
                              "Day": now.day.toString() + "-" +
                                  now.month.toString() + "-" +
                                  now.year.toString(),
                              "Time": now.hour.toString() + ":" +
                                  now.minute.toString() + ":" +
                                  now.second.toString(),
                            };
                            ref1.child(contact["key"]).update(edited).then((
                                value) => Navigator.pop(context));

                            DatabaseReference ref10 = ref2.push();
                            setState(() {
                              deletekey=ref10.key;
                              userskey=contact["key"];
                            });
                            ref10.set(transaction);
                            //ref2.push().set(transaction);

                            getacc(addamount);
                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "Insufficient Balance !! Refill Your Account",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }

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
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homepage(username:username,url:url,mail:mail)));
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
                  MaterialPageRoute(builder: (context) => history(username:username,url:url,mail:mail)));
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
              MaterialPageRoute(builder: (context) => AddContacts(username: username,url: url,mail:mail,)));
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

  Color gettypecolor(String type)
  {
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