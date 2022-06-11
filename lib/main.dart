import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/chat_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'screens/auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return 
   MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:ChatScreen(),
        home: StreamBuilder(
          stream:FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return const SplashScreen();
            }
            else if(snapshot.hasData)
            {
              return  ChatScreen();
            }
            else{
              return  const AuthScreen();
            }
          }
          ),
          ),
      
    );
  }
}
