import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  Query ref11;

  Widget buildcontactitems({Map<dynamic,dynamic> transactions}){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5,10,25,0),
        child: Container(
          height: 100,
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
                  Text(transactions["Name"],style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10,),
                  Icon(Icons.attach_money_rounded,color: Colors.blueAccent,size: 30,),
                  Text(transactions["Amount"],style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.w600),),
                  SizedBox(width: 20,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.calendar_today,color: Colors.blueAccent,size: 30,),
                  SizedBox(width: 10,),
                  Text(transactions["Day"],style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10,),
                  Icon(Icons.watch_later,color: Colors.blueAccent,size: 20,),
                  SizedBox(width: 5,),
                  Text(transactions["Time"],style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.w600),),
                  SizedBox(width: 20,),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       ref11 = FirebaseDatabase.instance.reference().child("Transactions");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,

      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(query: ref11 ,itemBuilder: (BuildContext context,
            DataSnapshot snapshot1,Animation<double>animation,int index){
          Map transactions = snapshot1.value;
          return buildcontactitems(transactions: transactions);
        },),
      ),

    );
  }
}
