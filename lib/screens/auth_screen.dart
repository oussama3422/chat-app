
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/auth_form.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../contoller/getx_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading=false;
  var auth=FirebaseAuth.instance;
  // ContollerApp controller=Get.put(ContollerApp());

Future<void>  _submitAuthenticationForm(String username,String email,String password,bool isLogin,File image,BuildContext ctx)async{
   UserCredential _authResult;
  try{
    setState(() {
      isLoading=true;
    });
    if(isLogin)
    {
        _authResult=await auth.signInWithEmailAndPassword(
        email: email, password: password
      );
    }
    else{
     _authResult=await auth.createUserWithEmailAndPassword(
      email: email, password:password,
     );
     final ref=  FirebaseStorage.instance.ref().child("user_Image").child(_authResult.user!.uid+".jpg");
      ref.putFile(image);
     //:::::::::get Link to Download to deal With My App:::::
     final url  = await ref.getDownloadURL();

    FirebaseFirestore.instance.collection('users').doc(_authResult.user!.uid).set(
          {
            'email':email,
            'username':username,
            'imageurl':url,
          }
        );
    }

   } on FirebaseAuthException catch(e){
     String message='Somthing Went Wrong';

     if(e.code=='weak-password')
     {
          message='The password is Too Weak';
     }
     else if(e.code=='invalid-email')
      {
          message='the Email That you enter Not Valid ';
      }
     else if(e.code=='email-already-in-use')
      {
          message='The acount is Aleardy Exist With Email ';
      }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.warning,color:Colors.grey[600],size: 20,),
            const SizedBox(width: 16),
            Text(message,style:  TextStyle(color: Colors.grey[600],fontSize:20,fontFamily: 'Pacifico'),),
          ],
        ),
        dismissDirection: DismissDirection.startToEnd,
        backgroundColor: const Color.fromARGB(255, 46, 34, 34),
      )
    );
   setState(() {
     isLoading=false;
   });
  }catch(e){
   setState(() {
     isLoading=false;
   });
   ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.warning,color:Colors.grey[600],size: 20,),
            const SizedBox(width: 16),
            Text('Exception Happend ',style:  TextStyle(color: Colors.grey[600],fontSize:20,fontFamily: 'Pacifico'),),
          ],
        ),
        dismissDirection: DismissDirection.startToEnd,
        backgroundColor: const Color.fromARGB(255, 46, 34, 34),
      )
    );
 }
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: AuthFrom(submitFunc:_submitAuthenticationForm,isLoading:isLoading),
    );
  }
}