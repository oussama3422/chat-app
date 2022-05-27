
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_form.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _auth=FirebaseAuth.instance;

  void _submitAuthenticationForm(String username,String email,String password,bool isLogin,BuildContext context)async{
   UserCredential _authResult;
  try{
    if(isLogin)
    {
        _authResult=await _auth.signInWithEmailAndPassword(
      email: email, password: password
      );
    }
    else{
     _authResult=await _auth.createUserWithEmailAndPassword(
      email: email, password: password
      );
    }

  } on FirebaseAuthException catch(error){
    if(error.code=='weak-password')
    {
      print('The password is Too Weak');
    }
    else if(error.code=='email-already-in-use')
    {
      print('The acount is Aleardy Exist With Email ');
    }
    else if(error.code=='Wrong Password')
    {
      print('password that you Entered Wrong');
    }
  }catch(error){
   print(error);
  }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AuthFrom(submit:_submitAuthenticationForm),
    );
  }
}