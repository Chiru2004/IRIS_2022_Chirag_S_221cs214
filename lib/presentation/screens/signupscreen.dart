import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messmanager/data/models/user.dart';


//import 'package:firebase_core/firebase_core.dart';


final database = FirebaseDatabase.instance;
//final _firebase = FirebaseAuth.instance; 
class SignupScreen extends StatefulWidget
{
const SignupScreen({super.key,required this.firebase});
final FirebaseAuth firebase;

@override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }   
}
class _SignupScreenState extends State<SignupScreen>
{

//variables declared in the class

var user= UserIndividual(name: "no_name", rollnumber: "000", email: "", password: "",userId: "",);
final formkey = GlobalKey<FormState>();
String firstenteredpassword ='';
bool isuploading = false;

//Functions used in the class

void senduserdataonline(){

Map<String,dynamic> useronline = {
   "name":user.name,
   "rollnumber": user.rollnumber,
   "email":user.email,
   "password":user.password,
  "mess": "",
  "messbalance": 0,
  "date":{
    "Starting":"",
    "ending":""
  }
};

try {
    database.ref().child("Users").child(user.userId).push().update(useronline);
    print("Mess pushed to database successfully!");
  } catch (error) {
    print("Error pushing Mess: ${error.toString()}");
  }

}

void onsignup()async{
bool issucces =formkey.currentState!.validate();

if(!issucces )
{
  //error message to handle the error in the image upload!
  return;
}
formkey.currentState!.save();

try{
  setState(() {
    isuploading = true;
  });
final usercredentials =
 await widget.firebase.createUserWithEmailAndPassword
     (
      email: user.email, 
      password: user.password
     );
     print(usercredentials);
user.userId=usercredentials.user!.uid;


 senduserdataonline();
 Navigator.of(context).pop();
}
on FirebaseAuthException catch(error)
{
error.message;
ScaffoldMessenger.of(context).clearSnackBars();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( error.message ?? 'Authentication')));
  }
 setState(() {
   isuploading = false;
 });
}


 @override
  Widget build(BuildContext context) 
  {

    Widget text = isuploading?
     const Text("Registering User",style: TextStyle(color: Colors.white),)
      :const Text("Sign up",style: TextStyle(color: Colors.white),);

   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(title: const Text("Enter the details")),  
     body: Padding(
       padding:  const EdgeInsets.all(9.0),
       child: SingleChildScrollView(
         child: Form(
           key: formkey,
           child: Column(
              children: [
                TextFormField(
                  onSaved: (value)
                        {
                        user.name =value!;
                        }
                         ,
                       validator:(value)
                             {
                              if(value ==null || value.trim().length <3 )
                              {
                                  return "Enter a name of atleast 3 character";
                              }
                              return null;
                              },
                              decoration:  InputDecoration(
                                 labelText:"Name",
                                 hintText: "Enter your name",
                                 enabledBorder: OutlineInputBorder
                                 (
                                   borderRadius:const BorderRadius.all(Radius.circular(0)),
                                   borderSide: BorderSide(color: Theme.of(context).colorScheme.primary,width: 2,)
                                 ),
                                focusedBorder:const OutlineInputBorder
                                (
                                   borderRadius: BorderRadius.all(Radius.circular(2)),
                                   borderSide: BorderSide(color:Colors.green , width: 2),
                                )     
                              ),
                            ),
                            const SizedBox(height: 9,),
                TextFormField(
                              onSaved: (value)
                              {
                                user.email =value!;
                               },
                             validator: (value)
                             {
                              if(value ==null || !value.contains("@") ||value.trim().length <3 )
                              {
                                  return "Enter a valid email address";
                              }
                              return null;
                            },
                              decoration:  InputDecoration(
                                labelText:"Email",
                                hintText: "Enter your email" ,
                                enabledBorder: OutlineInputBorder(
                                   borderRadius: const BorderRadius.all(Radius.circular(0)),
                                   borderSide: BorderSide(color:  Theme.of(context).colorScheme.primary,width: 2,)
                                ),
                                   focusedBorder:const  OutlineInputBorder(
                                     borderRadius: BorderRadius.all(Radius.circular(2)),
                                     borderSide: BorderSide(color:Colors.green , width: 2),
                                )     
                              ),
                            ),
                            const SizedBox(height: 9,),
                    TextFormField(
                              onSaved: (value){
                            user.rollnumber =value!;
                                              },
                             validator: (value)
                             {
                              if(value ==null || value.trim().length <3 )
                              {
                                  return "Enter a roll number of atleast 3 character";
                              }
                              return null;
                            },
                              decoration:  InputDecoration(
                                labelText:"Roll number",
                                hintText: "Enter the rollnumber",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary,width: 2,)
                                ),
                                focusedBorder: const OutlineInputBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(2)),
                                  borderSide: BorderSide(color:Colors.green , width: 2),
                                )     
                              ),
                            ),
                           const SizedBox(
                              height: 9,
                            ),
                             Card(
                              color: Theme.of(context).cardColor,
                              margin:const  EdgeInsets.all(3),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                              
                                                TextFormField(
                                                  onChanged: (value) {
                                                    firstenteredpassword=value;
                                                  },
                                          onSaved: (value){
                                                      
                                                  },
                                                             validator: (value)
                                                             {
                                if(value ==null || value.trim().length < 6 )
                                {
                                    return "Invalid-current password";
                                }
                                return null;
                                                            },
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(fontSize: 14),
                                  labelText:"Password",     
                                ),
                                                            ),
                                                        const SizedBox(height: 6,),    
                                                            TextFormField(
                                onSaved: (value){
                                                      user.password =value!;
                                                  },
                                                             validator: (value)
                                                             {
                                if(value ==null || value.trim().length < 6)
                                {
                                    return "Invalid-password";
                                }
                                if( value != firstenteredpassword)
                                {
                                   return "Password does not match";
                                }
                                return null;
                                                            },
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(fontSize: 14),
                                  labelText:"Confirm-Password",     
                                ),
                                                            ),
                                                            const SizedBox(height: 9,),
                                   ],
                                ),
                              ),
                             ),
                             const SizedBox(height: 7,),
                             OutlinedButton
                                 (
                style: OutlinedButton.styleFrom(
                  backgroundColor:  Theme.of(context).colorScheme.primary,
                side: const BorderSide(color: Colors.white, width: 2),
                ),
                
                onPressed: onsignup,
                child: text
              )
                          ],
                        )
                      ),
                    ),
                  ),
               );
             }
          }