import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:messmanager/data/models/mess.dart';
import 'package:messmanager/data/models/messreturnedvalues.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:messmanager/data/models/userdetails.dart';
import 'package:messmanager/presentation/screens/menuviewscreen.dart';


final messbase = FirebaseDatabase.instance;
final databaseref =messbase.ref();

class MessSelectionScreen extends StatefulWidget
{
  MessSelectionScreen({super.key,required this.userkey,required this.userid, required this.userdetailstoupdate});
  String userkey;
  String userid;
  userdetails userdetailstoupdate;
  @override
  State<MessSelectionScreen> createState() {
 return _MessSelectionScreenState();
  }
}
 class _MessSelectionScreenState extends State<MessSelectionScreen>{ 
List<Mess> Messes = [];
String messbalance = "0";
DateTime selecteddate=DateTime(100);



void onselect(String id,String messbalance,String startingdate) async
{
   Map<String,dynamic> usermessupdate = {
   "name":widget.userdetailstoupdate.name,
   "rollnumber": widget.userdetailstoupdate.rollnumber,
   "email":widget.userdetailstoupdate.email,
   "password":widget.userdetailstoupdate.password,
  "mess": id,
  "messbalance": int.parse(messbalance),
  "date":{
    "Starting":startingdate,
    "ending":""
  }
};

// code to update the mess of the user!
await messbase.ref("Users/${widget.userid}/${widget.userkey}").update(usermessupdate);
ScaffoldMessenger.of(context).clearSnackBars();
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mess Added successful")));
Navigator.of(context).pop();
}
List<String> messId=[];
void onentry(){

  List<Mess> onAdd=[];
  
databaseref.child("Messes").get().then((event) {
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
    var value1 = json.encode(value);
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

   setState(() {
 // print(onAdd);
  Messes =onAdd;
      }
     );
    }  
   }
  );
 }

 void makefolderformessusers(String messId,String userId,String name,String rollnumber)
 {
 databaseref.child("MessUsers/${messId}/${userId}").set({"name":name,"roll":rollnumber});
 }

void selectDate() async
{
var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if(pickedDate != null)
    {
      setState(() {
         selecteddate = pickedDate;
      });
     
    }
}

//function to increase the mess count in among the users

void increaseMesscount(String messId,int currentnumber)
{
  databaseref.child("Messes/${messId}").update({"occupants":currentnumber+1});
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
             title: const Text("Select your mess"),
           ),
           body: messbalance=="0" || selecteddate==DateTime(100)? 
           Center(
             child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(label: Text("Enter the Mess balance")),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                               messbalance=value;
                            });
                           
                          },
                        ),
                        const SizedBox(height: 5,),
                        ElevatedButton(
                          onPressed: selectDate,
                           child: const Text("Select the starting date"))
                      ],
                ),
                  )
                  ),
           ):
           
            ListView.builder(
              padding: const EdgeInsets.all(7),
              itemCount: Messes.length,
              itemBuilder: (context, index) {
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
                        content:  Text("Are you sure you want to proceed with ${Messes[index].title} Mess?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: (){
                              
                              onselect(messId[index],messbalance,selecteddate.toString());
                              //function to increase the count number
                              increaseMesscount(messId[index], Messes[index].occupied);
                              //fucntion to create a separate folder which contains the mess and the userid
                              makefolderformessusers(messId[index],widget.userid, widget.userdetailstoupdate.name!, widget.userdetailstoupdate.rollnumber!);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      );
                    },
                  );
                          }, child:const Text("Select",style: TextStyle(color: Colors.white),))
                          
                        ],
                      )
                  
                    ],
                  ),
                ),
              );
              
              },
            
           ),
    );
  }
}