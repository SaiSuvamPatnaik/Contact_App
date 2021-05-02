import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class history extends StatefulWidget {
  String username,url,mail;
  history({
    this.username,
    this.url,
    this.mail
});
  @override
  _historyState createState() => _historyState(username:username,url:url,mail:mail);
}

class _historyState extends State<history> {

  Query ref;
  String username,mail,url;

  _historyState({
    this.username,
    this.url,
    this.mail
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.reference().child("Transactions").child(username);

  }

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

        title: Text("History"),
        centerTitle: true,

      ),
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snap) {

          if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {

            Map data = snap.data.snapshot.value;
            List item = [];

            data.forEach((index, data) => item.add({"key": index, ...data}));


            return RawScrollbar(
              isAlwaysShown: false,
              thumbColor: Colors.redAccent,
              radius: Radius.circular(20),
              thickness: 5,
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10,15,10,0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 90,
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.fromLTRB(0,16,0,0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black,
                              child: Icon(Icons.person,size: 20,color: Colors.white,),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0,17,0,0),
                            child: Text(item[index]["Name"],style: TextStyle(fontSize: 18,color: Colors.redAccent,fontWeight: FontWeight.bold),),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(0,5,0,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.date_range,size: 18,),
                                SizedBox(width: 3,),
                                Text(item[index]["Day"],style: TextStyle(color: Colors.black,fontSize: 15)),
                                SizedBox(width: 10,),
                                Icon(Icons.lock_clock,size: 18,),
                                SizedBox(width: 3,),
                                Text(item[index]["Time"],style: TextStyle(color: Colors.black,fontSize: 15)),

                              ],
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.fromLTRB(0,17,10,0),
                            child: Text(item[index]["Amount"],style: TextStyle(fontSize: 19,color: Colors.black,fontWeight: FontWeight.bold),),
                          ),


                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          else
            return Text("");
        },
      ));
  }
}
