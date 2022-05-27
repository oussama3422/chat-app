
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class AuthFrom extends StatefulWidget {
  const AuthFrom({required this.submit, Key? key }) : super(key: key);

  final void Function(String email,String password,String username,bool isLogin,BuildContext ctx) submit;

   




  static const String _imageUrl = 'https://tse3.mm.bing.net/th?id=OIP.CDHDsbMAWk9cNcM7qAmAqwHaEo&pid=Api&P=0&w=295&h=184';
  static const String _imageUrl2 = 'https://t3.ftcdn.net/jpg/03/55/60/70/360_F_355607062_zYMS8jaz4SfoykpWz5oViRVKL32IabTP.jpg';


  @override
  State<AuthFrom> createState() => _AuthScreenState();

 
   
}

class _AuthScreenState extends State<AuthFrom> with SingleTickerProviderStateMixin {
   
   
  
   

  //  late bool isLoading;
   

   final formkey=GlobalKey<FormState>();
   
    String email='';
    String password='';
    String username='';
    bool _isLogin=true;

   TextEditingController passwordController=TextEditingController();

  //:::::::::::::::::::Animation Controller::::::::::::::::::
  AnimationController? controlleranimation;
  Animation<Offset>? slideAnimation;
  Animation<double>? opacityAnimation;
@override
  void initState() { 
    controlleranimation=AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
    slideAnimation=Tween(begin:const Offset(0,-0.15),end:const Offset(0,0)).animate(CurvedAnimation(parent: controlleranimation!, curve:Curves.fastOutSlowIn )) ;
    opacityAnimation=Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: controlleranimation!, curve:Curves.fastOutSlowIn )) ;
    super.initState();
  }
@override
  void dispose() {
    controlleranimation!.dispose();
    super.dispose();
  }
 
// ::::::::::::::::::::::::SUBMIT::::::::::::::::::::::::
 void submit() 
  {
   bool? isValid=formkey.currentState!.validate();
   FocusScope.of(context).unfocus();

   if(!isValid)
   {
     formkey.currentState!.save();
      widget.submit(email.trim(),password.trim(),username.trim(),_isLogin,context);
    
   }
  
  
  
  
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize=  MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          // key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[ 
            Transform.rotate(
              angle: 4/63,
              child: Container(
                padding: const EdgeInsets.all(40),
                margin: const EdgeInsets.only(top:60,bottom: 40),
                child:  const Text('MOVIC CHAT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromARGB(255, 230, 230, 230)),),
                decoration:  BoxDecoration(
                  image: const DecorationImage(image: NetworkImage(AuthFrom._imageUrl),scale: 0.1,filterQuality: FilterQuality.high ,fit: BoxFit.fill) ,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
              const SizedBox(height: 10,),
              const Text('Welcome,',style:  TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              const SizedBox(height: 6,),
              const Text('Sign in to continue!',style: TextStyle(fontSize: 26,color: Color.fromARGB(255, 39, 22, 43),fontWeight: FontWeight.bold),),
                    
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
                    if(!_isLogin)
                      TextFormField(
                      key: const ValueKey('username'),
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon:Icon(Icons.people,color: Colors.blue,),
                        label:Text('Full Name : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        hintText: 'Enter Full Name ',
                        hintStyle: TextStyle(color: Colors.white),
                      ),

                       onSaved: ((newValue) {
                        username=newValue!;
                      }),
                      validator: (val){
                         Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                         RegExp regex = RegExp(pattern.toString());
                        if(val!.isEmpty || !regex.hasMatch(val))
                        {
                          return 'Invalid Email' ;
                        }return null;
                      },




                    ),
                     TextFormField(
                      key: const ValueKey('email'),
                      onSaved: ((newValue) {
                        email=newValue!;
                      }),
                      validator: (val){
                        if(val!.isEmpty || !val.contains('@gmail.com'))
                        {
                          return 'Invalid Email' ;
                        }return null;
                      },
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.emailAddress,
                      decoration:const  InputDecoration(
                        icon: Icon(Icons.email,color: Colors.blue,),
                        label: Text('E-mail : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        hintText: 'Enter E-mail ',
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                     
                        TextFormField(
                        key: const ValueKey('password'),
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.visiblePassword,
                        decoration:  const InputDecoration(
                          icon:  Icon(Icons.password,color: Colors.blue,),
                          label:  Text('Password : ',style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          hintText: 'Enter Password  ',
                          hintStyle:   TextStyle(color: Colors.white),
                          suffixIcon:Icon(Icons.visibility),
                            ),        
                        validator: ( value) {
                          Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                           RegExp regex = RegExp(pattern.toString());
                          if (value!.isEmpty ) {
                          return 'Password is required';
                          }else if (!regex.hasMatch(value) || value.length<5 ) {
                            return 'Enter valid password';
                          } else{return null;}
                          
                          },
                                  
                          onSaved: (val)
                          {
                           password=val!;
                          },
                        ),
                      
                    if(!_isLogin)
                      AnimatedContainer(
                        duration:const Duration(milliseconds: 300) ,
                        curve: Curves.easeIn,
                        constraints: BoxConstraints(
                          minHeight:!_isLogin? 60:0,
                          maxHeight:!_isLogin?120:0,
                          ),
                        child: TextFormField(
                          
                        key: const ValueKey('confirmPassword'),
                        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        obscureText: true,
                        keyboardType:  TextInputType.visiblePassword,
                        decoration:  const InputDecoration(
                        
                          icon:Icon(Icons.password,color: Colors.blue,),
                          label:Text('Confirm Password : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          hintText: 'Confirm Password  ',
                          hintStyle: TextStyle(color:  Color.fromARGB(255, 239, 239, 239)),
                          suffixIcon: 
                            Icon(Icons.visibility),
                            ),
                          validator: !_isLogin? 
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
                           }:null,
                        ),
                      ),
                      //  if(controller.isLoading.value) const CircularProgressIndicator(color: Colors.purple,),
                       SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                          // key: formkey,
                          style:ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                           shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)))
                          ) ,
                          onPressed:submit,
                          child:  Text(!_isLogin ?'Sing Up':'Login',style:const TextStyle(color:Color.fromARGB(255, 250, 250, 250))),
                        ),
                      ),
                      TextButton(
                      child:  Text('${!_isLogin? 'LOGIN':'SIGNUP'} INSTEAD',style: const TextStyle(color: Color.fromARGB(255, 10, 10, 164),fontWeight: FontWeight.bold)),
                      onPressed:(){
                        setState(() {
                        _isLogin=!_isLogin;
                         });
                      },
                      ),
                  ],
               ),
            )
              
            
            ]
          
          ),
        ),
      ),
      
    );
  }
}