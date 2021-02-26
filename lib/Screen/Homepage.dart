import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_flutter/Screen/add_contacts.dart';
import 'package:thirty_days_flutter/Screen/contacts.dart';
import 'package:thirty_days_flutter/Screen/history.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  
  DatabaseReference ref;
  String Acc;
  String balance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.reference().child("User").child("Sai Suvam");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello User",style: TextStyle(fontSize: 25),),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => contacts()));
              },
            ),
          )
        ],
        centerTitle: true,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,40,0,0),
              child: Stack(
                children: [
                  Text("Welcome",style: TextStyle(fontSize: 65,fontWeight: FontWeight.bold,shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255,255, 0, 0),
                    ),] ),),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,65,0,0),
                        child: Text("Sai Suvam",style: TextStyle(fontSize: 65,fontWeight: FontWeight.bold,shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255,255, 0, 0),
                          ),] ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3,60,0,0),
                        child: Text("...",style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold,color: Colors.green ),),
                      ),


                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75,200,0,0),
                    child: Text("User Details",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.redAccent,
                        ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(17,250,0,0),
                    child: Container(
                      height: 235,
                      width: 340,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                        color: Color(0xFF002366),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Container(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20,60,0,0),
                                      child: Icon(Icons.qr_code_scanner_outlined,color: Colors.white,size: 30,),
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(60,60,0,0),
                                        child: Text("4580 9876 6521 3456",style: TextStyle(color: Colors.white,fontSize: 25),)
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(60,10,0,0),
                            child: Text("SAI SUVAM PATNAIK",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              Container(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(30,8,0,0),
                                      child: Text("Your Balance :-",style: TextStyle(color: Colors.white,fontSize: 25),)
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(200,10,0,0),
                                        child: Text("$balance",style: TextStyle(color: Colors.white,fontSize: 25),)
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(270,0,0,0),
                                        child: IconButton(
                                          icon: Icon(Icons.refresh,size: 30,color: Colors.white,),
                                          color: Colors.black,
                                          onPressed: ()async{
                                            DataSnapshot Snapshot = await ref.once();
                                            Map acc = Snapshot.value;
                                            setState(() {
                                              balance=acc["Balance"];
                                            });
                                          },
                                        )
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),

                    ),
                  ),


                ],
              ),
            ),
          )


        ],

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContacts()));
        },
        child: Icon(Icons.add,color: Colors.white,size: 20,),

      ),
    );
  }

}
