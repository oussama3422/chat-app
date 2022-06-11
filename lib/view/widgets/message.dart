import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screens/bubble_message.dart';
// import '../screens/bubble_message.dart';

class Message extends StatelessWidget {
   Message({Key? key}) : super(key: key);

    TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("CHAT").orderBy("createdAt",descending: true).snapshots(),
      builder: (BuildContext ctx,AsyncSnapshot snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        {
           return  Center(child:  CircularProgressIndicator(color:Colors.green[300]));
        }
      //   else if(snapshot.connectionState==ConnectionState.active)
       else{
            var doc=snapshot.data.docs;
            var user=FirebaseAuth.instance.currentUser;
            return ListView.builder(
              reverse: true,
              itemCount: doc.length,
              itemBuilder: (BuildContext ctx,index){
                 return BubbleMessage(
                   key:ValueKey(doc[index].documentID),
                   //:::::::::::::::get Message From firebase :::::::::::
                   message:doc[index]['message'],
                   //we check if the id isMe or the Other Person
                   isMe:doc[index]['userId']==user!.uid,
                   //::::::::::::::get  username From Firebase ::::::::::::::::::
                   username:doc[index]['username'],
 
                 );
              },
             
              );
        }
        
        // else{
        //   // ignore: null_check_always_fails
        //   return Container();
        // }

      } 
    );
  
  }
}