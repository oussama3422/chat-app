import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
   NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
    TextEditingController controller=TextEditingController();

    String message="";

  _sendMessage() async{
      var user= FirebaseAuth.instance.currentUser;
      var userData=await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
       FirebaseFirestore.instance.collection('CHAT').add({
              'message':message,
              'createdAt':Timestamp.now(),
              'username':userData['username'],
              'userId':user.uid,
           });
           controller.clear();
     }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Expanded(
      child: Container(
        width:100,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          ),
        child: TextFormField(
          enabled:   true,
          style: const TextStyle(color: Colors.black),
          controller:controller,
          decoration:    InputDecoration(
            hintText: 'Message',
             border: OutlineInputBorder(
               gapPadding: 5.0,
               borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(
              color: Colors.white, 
              width: 2.0,
              style: BorderStyle.none
              ),
            )
               ),
            onChanged: (newVal){
              setState(() {
              message=newVal;
              }); 
            },
        ),
      ),
    ),
     IconButton(
       color: Colors.green,
       onPressed:message.trim().isEmpty ? null : _sendMessage,
       icon: const Icon(Icons.send,size: 35),
       )
    ]);
  }
}