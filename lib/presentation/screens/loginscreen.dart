import 'package:flutter/material.dart';
import 'package:messmanager/presentation/screens/adminscreen.dart';
import 'dart:io';
import 'package:messmanager/presentation/screens/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messmanager/data/models/user.dart';

final _firebasee = FirebaseAuth.instance;
class LoginScreen extends StatefulWidget
{

const LoginScreen({super.key});

@override
   State<LoginScreen> createState() {
   return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
{

//All initial variables

final formkey = GlobalKey<FormState>();
String _enteredemail="";
String _enteredpassword = "";
bool ispasswordvisible = false;

// all the functiond used to fetch and use the data

//function to execute on login
void onLogin() async 
{
  bool isvalid = formkey.currentState!.validate();

  if(!isvalid)
  {
    return;
  }
 
formkey.currentState!.save();
 

 try{
var usercredentials=await _firebasee.signInWithEmailAndPassword
      (
        email: _enteredemail,
        password: _enteredpassword
      ); 
 print(usercredentials.toString());
 //Navigator.of(context).pop();
 }
 on FirebaseAuthException catch(e){
 ScaffoldMessenger.of(context).clearSnackBars();
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message?? " Login Failed")));
 
 }
//Code to handle when its validd
}

  @override
  Widget build(BuildContext context) {

   // Widget boxcontent =    
    return Scaffold(
     backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Container(
                width: 250,
                 padding: const EdgeInsets.only(bottom: 30),
                  child: const Row(
                   children: [
                    Icon(
                      Icons.soup_kitchen_outlined, 
                      size:90,
                      color: Colors.white,
                      ),
                    Text("Mess \nManager ",style: TextStyle(
                       fontSize: 30,
                       color: Colors.white,
                       fontWeight: FontWeight.w500
                       ),
                       )
                   ],
                  ),
                ),
              Card(
                elevation: 25,
                 margin: const EdgeInsets.all(14),
                 child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formkey,
                       child: Column(
                         children: [
                            TextFormField(
                              onSaved: (newValue) {
                                if(newValue != null)
                                {
                                   _enteredemail = newValue;
                                }
                               
                                },
                                validator: (value){
                                  if(value == "admin" )
                                   {
                                    Navigator.push(
                                       context,
                                        MaterialPageRoute(builder: (context) => AdminScreen(),));
                                  }
                               if(  value == null|| value.isEmpty || !value.contains('@'))
                              {
                                return 'Enter a valid emailId';
                              }
                             return null;
                            },
                              decoration:const InputDecoration(
                                labelText:"Email",     
                              ),
                            ),
                           TextFormField(
                            
                            obscureText: !ispasswordvisible,

                            onSaved: (newValue) 
                            {    
                              if(newValue != null)
                              {
                                 _enteredpassword = newValue ;
                              }                          
                            },
                             validator:(value)
                             {
                              if(value ==null || value.trim().length < 6 )
                              {
                                  return "Invalid-password";
                              }
                              return null;
                            },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  iconSize: 20,
                                  icon: Icon(
                                   ispasswordvisible?Icons.visibility_off:Icons.visibility
                                  ),
                                  onPressed: ()
                                  {
                                    setState(() {
                                      ispasswordvisible = !ispasswordvisible;
                                      
                                    });
                                     
                                  },
                                ),
                                labelText:"Password",     
                              ),
                            ),
                            const  SizedBox(height: 10,),
              ElevatedButton(
                onPressed: onLogin,
               child: const Text("Login")
               )
                         ],
                      )
                    ),
                  ),
                ),
              ),
             
               const  SizedBox(height: 10,),
               Container(
                height: 2,
                width: MediaQuery.of(context).size.width * .7,
                color: Colors.white,
               ),
               const  SizedBox(height: 10,),
               const  Text("Don't have an account? then",
               style: TextStyle(color: Colors.white),),
               const  SizedBox(height: 9,),
              OutlinedButton
              (
                style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2),
                ),
                
                onPressed: ()async{
                 Future u= Navigator.of(context).push<User>(MaterialPageRoute(builder: (context) => SignupScreen(firebase: _firebasee),));
                },
                child: const Text(
                    "Sign-up",
                    style: TextStyle(
                      color: Colors.white
                   ),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}