
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/image_picker.dart';
import 'package:get/get.dart';

import '../../contoller/getx_controller.dart';


class AuthFrom extends StatefulWidget {
   AuthFrom({required this.submitFunc, required this.isLoading,Key? key }) : super(key: key);

  final Function(String email,String password,String username,bool isLogin,File image,BuildContext ctx) submitFunc;
  final bool isLoading;

  static const String _imageUrl = 'https://lh3.googleusercontent.com/a-/AOh14GhE5KZT2YnSLen0nbpIHoa0Rr27KLtJ-lnLc6S8yw=s288-p-rw-no';
  static const String _imageUrl2 = 'https://t3.ftcdn.net/jpg/03/55/60/70/360_F_355607062_zYMS8jaz4SfoykpWz5oViRVKL32IabTP.jpg';

  @override
  State<AuthFrom> createState() => _AuthFromState();
}

class _AuthFromState extends State<AuthFrom> {
   final contollerApp=Get.put(ContollerApp());
    bool isLogin=false;
  //  late bool isLoading;
   final formkey=GlobalKey<FormState>();

    String email="";

    String password="";

    String username="";

   TextEditingController passwordController=TextEditingController();

//:::::::::::::::Picked Image Method::::::::::::::::::::::::::::::: 
  File? userImageFile;

  void pickerimage(File imagePicked){
    userImageFile=imagePicked;  
  }

  //:::::::::::::::::::Animation Controller::::::::::::::::::
  submit() 
  {
    bool isValid;
   isValid = formkey.currentState!.validate();
   if(userImageFile==null && !isLogin )
   {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.cyan, content: Row(children: const[Icon(Icons.error),SizedBox(width: 20),Text("Please Pick Image ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Pacifico",),)],)));
   }

     if(isValid)
    {
       formkey.currentState!.save();
       widget.submitFunc(password.trim(),email.trim(),password.trim(),isLogin,userImageFile!,context);
      // print("Username:::IS::::"+username);
      // print("email:::IS::::"+email);
      // print("password:::IS::::"+password);
      // print(" Image Is :::>  $userImageFile");
     }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize=  MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Form(
          key:formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[ 
            Transform.rotate(
              angle: 4/88,
              child: Container(
                padding: const EdgeInsets.all(60),
                margin: const EdgeInsets.only(top:60,bottom: 20,right: 15,left: 15),
                // child:  const Text('MOVIC CHAT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromARGB(255, 8, 10, 104)),textAlign: TextAlign.start),
                decoration:  BoxDecoration(
                  image: const DecorationImage(image: NetworkImage(AuthFrom._imageUrl),scale: 0.1,filterQuality: FilterQuality.high ,fit: BoxFit.fill) ,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
              const SizedBox(height: 10,),
              const Text('Welcome,',style:  TextStyle(fontSize: 26,fontWeight: FontWeight.bold,fontFamily:'Pacifico'),),
              const SizedBox(height: 6,),
              const Text('Sign in to continue!',style: TextStyle(fontSize: 26,color: Color.fromARGB(255, 39, 22, 43),fontWeight: FontWeight.bold,fontFamily: 'Pacifico'),),                    
            Container(
             padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              image: const DecorationImage(image: NetworkImage(AuthFrom._imageUrl2),scale: 0.1,filterQuality: FilterQuality.high ,fit: BoxFit.fill)
              ),
            child: 
               
                 Column(
                    children: [
                      if(!isLogin)
                       ImagePick(pickerimage),
                      if(!isLogin)
                        TextFormField(
                        key: const ValueKey('username'),
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          icon:Icon(Icons.people,color: Colors.blue,),
                          label:Text('Full Name : ',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),),
                          hintText: 'Enter Full Name ',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
               
                         onSaved: ((newValue) {
                            username=newValue!;
                        }),
                        validator: (val){
                          if(val!.isEmpty)
                          {
                            return 'Field Is Empty' ;
                          }
                          else{return null;};
                        },
                      ),
                       TextFormField(
                        key: const ValueKey('email'),
                        onSaved: ((newValue) {
                            email=newValue!;
                        }),
                        validator: (val){
                          if(val!.isEmpty || !val.contains('@'))
                          {
                            return 'Invalid Email' ;
                          }
                          else{return null;}
                        },
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.emailAddress,
                        decoration:const  InputDecoration(
                          icon: Icon(Icons.email,color: Colors.blue,),
                          label: Text('E-mail : ',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),),
                          hintText: 'Enter E-mail ',
                          fillColor: Colors.black,
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                          TextFormField(
                          key: const ValueKey('password'),
                          controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.visiblePassword,
                          decoration:  const InputDecoration(
                            icon:  Icon(Icons.password,color: Colors.blue,),
                            label:  Text('Password : ',style:  TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),),
                            hintText: 'Enter Password  ',
                            hintStyle:   TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            suffixIcon:Icon(Icons.visibility),
                              ),        
                          validator: ( value) {
                            if (value!.isEmpty || value.length<5) {
                               return 'Password is required';
                            } else{return null;}
                            },
                            onSaved: (val)
                            {
                              password=val!;
                            },
                          ),
                        
                      if(!isLogin)
                        TextFormField(
                        key: const ValueKey('confirmPassword'),
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),
                        obscureText: true,
                        keyboardType:  TextInputType.visiblePassword,
                        decoration:  const InputDecoration(
                        
                          icon:Icon(Icons.password,color: Colors.blue,),
                          label:Text('Confirm Password : ',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),),
                          hintText: 'Confirm Password  ',
                          hintStyle: TextStyle(color:  Color.fromARGB(255, 0, 0, 0)),
                          suffixIcon: Icon(Icons.visibility),
                            ),
                          validator: 
                           (val)
                           {
                             if(val!=passwordController.text)
                             {
                                 return 'Password does not Match!';
                             }
                             else
                             {
                                return null;
                             }
                           },
                        ),
                        //  if(controller.isLoading.value) const CircularProgressIndicator(color: Colors.purple,),
                        
                        if(!widget.isLoading)
                        SizedBox(
                            width: double.infinity,
                            child:ElevatedButton(
                            // key: formkey,
                            style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                             shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)))
                            ) ,
                            onPressed:submit,
                            child:  Text(!isLogin ?'Sing Up':'Login',style:const TextStyle(color:Color.fromARGB(255, 250, 250, 250),fontSize: 20,fontFamily: 'PatrickHand')),
                          ),
                        ),
                        widget.isLoading?
                        const CircularProgressIndicator(
                            color: Colors.blueAccent,strokeWidth: 3,
                            )
                            :
                      
                        TextButton( 
                          child:!isLogin?Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:const 
                            [
                              
                               Text('Already Have Account',style:  TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'PatrickHand')),
                                SizedBox(width: 7), 
                               Text('LOGIN',style:  TextStyle(decoration: TextDecoration.underline, color: Color.fromARGB(255, 0, 0, 0),fontSize: 21,fontWeight: FontWeight.bold,fontFamily: 'PatrickHand')),
                            ],
                          )
                          :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:const 
                            [
                              
                               Text('Don\'t Have Account',style:  TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'PatrickHand')),
                              SizedBox(width: 7), 
                               Text('SING UP',style:  TextStyle(decoration: TextDecoration.underline,color: Color.fromARGB(255, 0, 0, 0),fontSize:21,fontWeight: FontWeight.bold,fontFamily: 'PatrickHand')),
                            ],
                          ),
                          onPressed:()
                          {
                            if(isLogin==true)
                              {
                                setState(() {
                                   isLogin=false;
                                });
                              }
                             else{
                                  setState(() {
                                    isLogin=true;
                                  });
                                }
                          }
                          ),
                        
                    ],
            ),
              
            ),
            ]
          
          ),
        ),
      ),
      
    );
  }
}