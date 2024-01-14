import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/data/models/messreturnedvalues.dart';
import 'package:messmanager/data/models/userdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messmanager/data/models/mess.dart';
import 'package:messmanager/presentation/screens/menuviewscreen.dart';
import 'package:messmanager/presentation/screens/messchangescreen.dart';
import 'dart:convert';
import 'package:messmanager/presentation/screens/messselectionscreen.dart';
import 'package:messmanager/presentation/widgets/formtochangemessbalance.dart';
class UserMenu extends StatefulWidget
{
const UserMenu({super.key,required this.id});
final String id;
  @override
  State<UserMenu> createState() {
    return _UserMenuState();
  }
}
var userdata = FirebaseAuth.instance;
var databasee = FirebaseDatabase.instance;
var database = databasee.ref();

class _UserMenuState extends State<UserMenu>
{

  //Required Variables
  bool isfetching = true;
  bool ismessselcted = false;
  String userkey="";
userdetails user=userdetails();
messvalues messdata=messvalues();
Mess messval=Mess(title: "", menu: {}, number: 0, occupied: 0, vegnonveg: "", perdaycost: 0);


//Required Functions
void onopen()
{
  database.child("Users/${widget.id}").get().then((value){
 /// print(value.value);
  
  
    var data =  json.encode(value.value);
    Map<String,dynamic> userdata= json.decode(data);
    userdata.forEach((key, value) {
      userkey=key;
    user= userdetails.fromJson(value);
     });
     
if(user.mess != "")
{
  
  database.child("Messes/${user.mess}").get().then((value){
    print(value.value);
    String jsonstring = json.encode(value.value);
  Map<String,dynamic> usermess = json.decode(jsonstring);
  messdata = messvalues.fromJson(usermess);

  setState(() {
    ismessselcted=true;
  messval = Mess(
      title: messdata.title!
      , menu: {
        Days.monday:DayMenu(
             breakfast: messdata.menu!.monday!.breakfast!,
              lunch:messdata.menu!.monday!.lunch!,
               supper: messdata.menu!.monday!.supper!,
                dinner: messdata.menu!.monday!.dinner!
                ),
          Days.tuesday:DayMenu(
              breakfast: messdata.menu!.tuesday!.breakfast!,
               lunch: messdata.menu!.tuesday!.lunch!,
                supper: messdata.menu!.tuesday!.supper!,
                 dinner: messdata.menu!.tuesday!.dinner!
                 ),
             Days.wednesday:DayMenu(
              breakfast: messdata.menu!.wednesday!.breakfast!,
               lunch: messdata.menu!.wednesday!.lunch!,
                supper: messdata.menu!.wednesday!.supper!,
                 dinner: messdata.menu!.wednesday!.dinner!
                 ),
                 Days.thursday:DayMenu(
              breakfast: messdata.menu!.thursday!.breakfast!,
               lunch: messdata.menu!.thursday!.lunch!,
                supper: messdata.menu!.thursday!.supper!,
                 dinner: messdata.menu!.thursday!.dinner!
                 ),
                 Days.friday:DayMenu(
              breakfast: messdata.menu!.friday!.breakfast!,
               lunch: messdata.menu!.friday!.lunch!,
                supper: messdata.menu!.friday!.supper!,
                 dinner: messdata.menu!.friday!.dinner!
                 ), 
                 Days.saturday:DayMenu(
              breakfast: messdata.menu!.saturday!.breakfast!,
               lunch: messdata.menu!.saturday!.lunch!,
                supper: messdata.menu!.saturday!.supper!,
                 dinner: messdata.menu!.saturday!.dinner!
                 ),
                 Days.sunday:DayMenu(
              breakfast: messdata.menu!.sunday!.breakfast!,
               lunch: messdata.menu!.sunday!.lunch!,
                supper: messdata.menu!.sunday!.supper!,
                 dinner: messdata.menu!.sunday!.dinner!
                 ),  

      }, 
      number: messdata.totalnumber!,
       occupied: messdata.occupants!,
        vegnonveg: messdata.vegnonveg!,
         perdaycost:messdata.perdaycost!
          );  
         }
         );
        }
      );
    }
     // Code to change the value of the var when the value has already returned.
   setState(() {
     isfetching=false;
   }
    );
     }
      );
       }
@override
  void initState() {
   onopen();
    super.initState();
  }


@override
  void dispose() {
    //userdata.signOut();
    super.dispose();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void onselect() async
  {
   await Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
     MessSelectionScreen(
      //we are sending all the details need to update the mess in the user database
         userdetailstoupdate: user,
         userid:widget.id,
         userkey: userkey,
          ),
          )
          );
          setState(() {
            onopen();
          }
        );
      }




  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      key: _scaffoldKey,
       appBar: AppBar(
     title: const Text('welcome'),
     actions: [
      IconButton(
         onPressed: ()
         {
         // here we arite the code for the logging out of the account
         userdata.signOut();
         },
          icon: Icon(Icons.exit_to_app,
                      color:Theme.of(context).colorScheme.primary ))
     ],
    ),
    
    drawer: Drawer(
      child: ListView(
        children: [
          DrawerHeader(

            child: const Text("Queries",style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
               const Color.fromARGB(255, 57, 2, 2),
                Theme.of(context).colorScheme.primary.withOpacity(0.98)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft
              ),
              color: Theme.of(context).colorScheme.primary
            ),
            ),
            ListTile(
              
              title: ismessselcted? const Text("Mess change"):const Text("Register for a mess"),
              onTap:  (){
               !ismessselcted ? Navigator.of(context).pop():
//opens a page where mess change can be done
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
            MessChangeScreen(
                userkey: userkey,
               userid: widget.id,
                currentmessid: user.mess!,
                 messname:messdata.title!,
                 instance: databasee,
                studentname: user.name!,
                studentroll: user.rollnumber!,
                messoccupants: messdata.occupants!,
                 )
            )
            ).then((value) => _scaffoldKey.currentState!.closeDrawer());  
              },
            ),
            ListTile(
              title:ismessselcted && messdata.perdaycost! >= user.messbalance! ?
              const Text("Add mess balance"): const Text("Mess balance is sufficient"),

              onTap: (){
               ismessselcted && messdata.perdaycost! >= user.messbalance! ?
                showDialog(
  context: context,
  builder: (BuildContext context)=>MyFormDialog(
     studentid: widget.id,
      studentkey: userkey,
       instance: databasee,
       currentbalance: user.messbalance!,
       )
).then((value) {_scaffoldKey.currentState!.closeDrawer();
 setState(() {
             onopen();
          });
          
})
               
               : Navigator.of(context).pop();
         
            },
          ),            
        ],
      ),
    ) ,
    body:isfetching ? const Center(child: CircularProgressIndicator(),):  Column(
      children: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Theme.of(context).colorScheme.primary,width: 2)
              ),
             // color: Colors.white,
             child: Padding(
              padding: const EdgeInsets.all(12),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Center(child:  Text("User Details",style: TextStyle(fontWeight: FontWeight.bold)
                ,)
                ,)
               ,
                 const SizedBox(height: 2,),
                 Container(height: 2,color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                 ),
                 const SizedBox(height: 2,),
                 Text(user.name!,style: const TextStyle(fontSize: 25),),
                 const SizedBox(height: 7,),
                 Text(user.rollnumber!),
                 const SizedBox(height: 7,),
                 Text(user.email!)
                ],
               ),
             ),
            ),
          ),
        ),
         const SizedBox(height: 3,),
         Container(
          width: double.infinity,
          padding:const  EdgeInsets.all(7),
           child:!ismessselcted ? Align(
            alignment: Alignment.center,
            child:  TextButton(
              style: ButtonStyle(),
            onPressed:onselect, 
            child:const Text("Register for a mess") 
        ),
           ) :Card(
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           const Center(child: Text("Mess Details",style: TextStyle(fontWeight: FontWeight.bold),
                           ),
                           ),
                 const SizedBox(height: 5,),
                          Text("${messdata.title}",style: const TextStyle(fontSize: 21),),
                          const SizedBox(height: 2,),   
                          Text("Mess Balance: ${user.messbalance.toString()}"),
                            Row(
                              children: [
                             Text("${messdata.vegnonveg}",style: const TextStyle(fontSize: 15),),
                             const Spacer(),
                            TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context) => MenuViewScreen(mess: messval),));
                          }, child: const Text("View Menu"))
                              ],
                            ),
                         const SizedBox(height: 4,)
                        ],
                      ),
                    ),
                     ),
         ),
        
      ],
    ),
    );
  }
}