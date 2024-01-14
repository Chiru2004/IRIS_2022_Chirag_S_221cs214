import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:messmanager/data/models/mess.dart';
import 'package:messmanager/data/models/messreturnedvalues.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:messmanager/data/models/userdetails.dart';
import 'package:messmanager/presentation/screens/menuviewscreen.dart';




class MessChangeScreen extends StatefulWidget
{
  MessChangeScreen(
      {super.key,
      
      required this.userkey,
      required this.userid,
      required this.currentmessid,
      required this.messname,
      required this.instance,
      required this.studentname,
      required this.studentroll,
      required this.messoccupants
      });
  String userkey;
  String studentname;
  String studentroll;
  String userid;
  String currentmessid;
  String messname;
  int messoccupants;
  FirebaseDatabase instance;

  @override
  State<MessChangeScreen> createState() {
 return _MessSelectionScreenState();
  }
}
 class _MessSelectionScreenState extends State<MessChangeScreen>{ 
List<Mess> Messes = [];
bool isdatafetched = false;

List<String> messId=[];


//functions that will be called


void onentry()async{
  List<Mess> onAdd=[];

await widget.instance.ref().child("Messes").get().then((event) {
  var data= event.value;
  if(data != null)
  {
  String jsonstring = json.encode(data);
  Map<String,dynamic> messData = json.decode(jsonstring);
  // print(messData);
  messData.forEach((key, value) {
  messId.add(key);
 
    if(value != null)
    {
  //  var value1 = json.encode(value);
    //print(value1);
    
    messvalues messdata = messvalues.fromJson(value);
    Mess messval = Mess(
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

      }, number: messdata.totalnumber!,
       occupied: messdata.occupants!,
        vegnonveg: messdata.vegnonveg!,
         perdaycost:messdata.perdaycost! );
 
    onAdd.add(messval);
    }  
  }
);
         } 
          }
           );

 setState(() {
 // print(onAdd);
  Messes.addAll(onAdd);
  isdatafetched = true;
  int count=0;
 for(Mess mess in onAdd )
 {
  
  if(mess.title == widget.messname)
    {
     Messes.remove(mess);
     messId.removeAt(count);
    }
    count++;
         } 
     }  );

            }


 void messchange(
   String currentmessid,
   String changedmessid,
    String studentid, 
    String studentkey,
    String currentmessname,
    String changedmessname,
    int changedmessoccupants
    ) async
 {
  // make a separate folder called mess requests

await widget.instance.ref().child("MessRequests/Requests/${studentid}").set(
  {
  "studentid":studentid,
  "studentkey":studentkey,
  "Studentname":widget.studentname,
  "Studentroll":widget.studentroll,
  "currentmessid":currentmessid,
  "changedmessid":changedmessid,
  "state":"request",
  "currentmessname":currentmessname,
  "changedmessname":changedmessname,
  "currentmessoccupants": widget.messoccupants,
    "changemessoccupants": changedmessoccupants
  }
  );
//

ScaffoldMessenger.of(context).clearSnackBars();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Request sent")));
Navigator.of(context).pop();

 }


@override
  void initState() {
   onentry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
           appBar: AppBar(
             title: const Text("Apply for a Mess change"),
           ),
           body: isdatafetched?
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    
                    child: Padding(padding: EdgeInsets.all(7),
                    child: ListTile(
                      title: Text(widget.messname),
                      subtitle: const Text("Current mess"),
                    ),
                    ),
                  ),
                  Expanded(
                    child: Scaffold(
                      body: ListView.builder(
                        padding: const EdgeInsets.all(7),
                        itemCount: Messes.length,
                        itemBuilder: (context, index) {
                          
                            print(Messes.length);
                        return Card(
                          color: Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(Messes[index].title,style: const TextStyle(fontSize: 25,color: Colors.white),),
                                const SizedBox(height: 4,),
                                Container(
                                  color: Colors.white,
                                  height: 2,
                                ),
                                const SizedBox(height: 4,),
                                Row(
                                  children: [
                                    Column(children: [
                                       Text("${Messes[index].occupied}/${Messes[index].number} users",
                                       style: const TextStyle(
                                        color: Colors.white
                                        ),
                                        ),
                                       const SizedBox(height: 3,),
                                       Text(
                                        Messes[index].vegnonveg,
                                       style: const TextStyle(color: Colors.white),)
                                    ],
                                    ),
                                    const Spacer(),
                                    OutlinedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MenuViewScreen(mess: Messes[index]),));
                                    }, child:const Text("View Menu",style: TextStyle(color: Colors.white),)),
                                    const SizedBox(width: 4,),      
                                    TextButton(onPressed: (){
                                  showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                 return AlertDialog(
                                  title: const  Text("Confirmation"),
                                  content:  Text("Are you sure you want to change to ${Messes[index].title} Mess?"),
                                   actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("Cancel"),
                                     ),
                                     TextButton(
                                      onPressed: (){
                                        messchange(
                                          widget.currentmessid,
                                           messId[index],
                                            widget.userid,
                                             widget.userkey,
                                              widget.messname,
                                               Messes[index].title,
                                               Messes[index].occupied
                                               );
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Confirm"),
                                    ),
                                  ],
                                );
                              },
                            );
                                    }, child:const Text("Change",style: TextStyle(color: Colors.white),))
                                    
                                  ],
                                )
                            
                              ],
                            ),
                          ),
                        );
                        
                        },
                      
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator(),),
    );
  }
}