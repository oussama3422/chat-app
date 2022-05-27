import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/auth_screen.dart';

void main() 
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
        home: AuthScreen(),
      
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);




  void showData()
  {
    FirebaseFirestore.instance.collection('/chat/wwIZf9UiYPo0MAiisZax/messages').add(
      {'text':'Add Item'},
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WHAT\'s Movic UP'),
        centerTitle: true,
      ),
      body: StreamBuilder(
              builder: (ctx, AsyncSnapshot snapShot){
                if(snapShot.connectionState==ConnectionState.waiting)
                {
                  return const CircularProgressIndicator(color: Colors.purple);
                }
                var docs=snapShot.data!.docs;
                return ListView.builder(itemBuilder: (
                  (context, index) {
                    return SizedBox(child: Text(docs[index]['text']),);
                    }
                ));
              }
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
