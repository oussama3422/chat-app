import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
           color: Colors.white,
           child:Column(children: [
           Image.asset("img/Loading_icon.gif"),
           const SizedBox(height: 8),
           const Text('Loading .....',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
           ],)
      
    
    );
  }
}