import 'dart:convert';
//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:messmanager/data/models/mess.dart';
import 'package:messmanager/data/models/user.dart';
import 'package:messmanager/data/models/messreturnedvalues.dart';
import 'package:messmanager/presentation/screens/addmessscreen.dart';
import 'package:messmanager/presentation/screens/managerequestscreen.dart';
import 'package:messmanager/presentation/screens/menuviewscreen.dart';
class AdminScreen extends StatefulWidget
{
  const AdminScreen({super.key});
@override
  State<AdminScreen> createState() {
return _AdminScreenState();
  }
}
final database = FirebaseDatabase.instance;
final databaseref =database.ref();

class _AdminScreenState extends State<AdminScreen>
{

  //Initialized value of the variables

List<Mess> Messes = [];
bool fetchinguser = true;
List<String> keys = [];
List<UserIndividualfetchedAdmin> fetchedIndi=[];


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
    keys.add(key.toString());
    if(value != null)
    {
   // var value1 = json.encode(value);
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

      }, number: messdata.totalnumber!, occupied: messdata.occupants!, vegnonveg: messdata.vegnonveg!, perdaycost:messdata.perdaycost! );
 /// print(keys[0]);
    onAdd.add(messval);
    }  
  }
);
   setState(() {
 // print(onAdd);
  Messes =onAdd;
});
  }  
}
);
}
//function to fetch th list of elements
void fetchmessusers(String messId,int occupants) async
{
//List<UserIndividualfetchedAdmin> fetchedIndivals=[];
 await databaseref.child("MessUsers/${messId}").get().then(
    (value){
    String uservaluesString = json.encode(value.value);
    print(uservaluesString);
    Map<String,dynamic> uservalues = json.decode(uservaluesString);
    uservalues.forEach((key, value) {
    UserIndividualfetchedAdmin tempuser = UserIndividualfetchedAdmin(id: "", rollnumber: "", name: "");
    tempuser.id = key;
    fetchuserclass users = fetchuserclass.fromJson(value);
    tempuser.name = users.name!;
    tempuser.rollnumber = users.roll!;
    fetchedIndi.add(tempuser);
    }
    );
    print(fetchedIndi.length);
    }
    );
    setState(() 
    {
  fetchinguser = false;
    });
    showMessuser(messId,occupants);    
    // 
    setState(() {
      onentry();
    });
}
//function to the modal sheet
void showMessuser(String messid,int occupants) async
{
 await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
     return fetchinguser ? const Text("fetching") : ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500),
       child: ListView(
       children: fetchedIndi.map((value){
        return ListTile(
          title: Text(value.name),        
          subtitle: Text(value.rollnumber),
         trailing:TextButton(onPressed: (){
             //remove the user from MessUser list and also remove the user mess details
             
             showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
        title: const  Text("Confirmation"),
        content: const Text("Are you sure you want to deallocate this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: ()
            { 
              // code part to deallocate all the users
       
              //remove from the Messusers list
              databaseref.child("MessUsers/${messid}/${value.id}").remove();
              //decrease the count
              databaseref.child("Messes/${messid}").update({"occupants":occupants-1});
              //update the upser
              deallocatemessfromuser(value.id);
              Navigator.pop(context);
            },
            child: const Text("Confirm"),
          ),
        ],
           );
         },
       );
       //reomve from the 
         }, child: const Text("deallocate") 
         ),          
        );
       }).toList(),
       ),
     );
   },
  );
  // this will refresh the list as fresh,so tht the list can be used again!
  fetchedIndi=[];   
}

// function to change the user from the screen
void deallocatemessfromuser(String userId)async {
 String userkey="";
  await databaseref.child("Users/${userId}").get().then((value){
   String val = json.encode(value.value);
   Map<String,dynamic> user = json.decode(val);
   user.forEach((key, value) {
    userkey=key;
   });
  });
if(userkey != "")
{
    await databaseref.child("Users/${userId}/${userkey}").update({"mess":""});
    Navigator.pop(context);
}


}
@override
  void initState() 
  { 
 onentry();
    super.initState();
  }
@override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: const Text("Admin"),
      actions: [
         TextButton(
        onPressed: ()async{
             Mess? addedmess = await Navigator.push<Mess>(context, MaterialPageRoute(builder: (context) => AddMessScreen(database: database),));
             if(addedmess != null)
             {
              onentry();
             }
        },
        child:const Text("Add a mess") )
      ],
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: ElevatedButton(onPressed: () async{
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminRequest(instance: database),));
    setState(() {
      onentry();
    });
    },
     child: const Text("Manage Requests")),
    body: Center(
      child:Messes.isEmpty? const Center(
        child: Text("Loading"),
        ) : ListView.builder(
              padding: const EdgeInsets.all(9),
              itemCount: Messes.length,
              itemBuilder: (context, index) 
              {
              return Card(
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const SizedBox(height: 3,),
                      Text(
                      Messes[index].title,
                      style: const TextStyle(fontSize: 25,color: Colors.white),),
                      const SizedBox(height: 3,),
                      Container(
                        color: Colors.white,
                        height: 2,
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: 
                        [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text("${Messes[index].occupied}/${Messes[index].number} users",style: const TextStyle(color: Colors.white),),
                             const SizedBox(height: 1,),
                             Text(Messes[index].vegnonveg,style: const TextStyle(color: Colors.white),)
                          ],
                        ),
                          const Spacer(),
                          ElevatedButton(
                            style:const  ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 195, 28, 16)),
                            shape: MaterialStatePropertyAll(
                             RoundedRectangleBorder(
                               borderRadius: BorderRadius.all(Radius.circular(9))
                               )
                               )
                            ),
                            onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => MenuViewScreen(mess: Messes[index]),));
                          }, child:const Text( "View Menu",
                                  style: TextStyle(
                                       color: Colors.white
                                       ),
                                )
                             ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                      ElevatedButton(
                        style:const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 195, 28, 16)),
                          shape: MaterialStatePropertyAll(
                             RoundedRectangleBorder(
                               borderRadius: BorderRadius.all(Radius.circular(9))
                               )
                               )
                               ),
                        onPressed: (){
                        fetchmessusers(keys[index],Messes[index].occupied);
                  
                        //view all the user and delete the users
                        // showMessuser();
                        }, child: const Text("Mess users",style: TextStyle(color: Colors.white),)),
                       const Spacer(),
                     TextButton.icon(
                            onPressed: (){
                            if(Messes[index].occupied != 0)
                            {
                               ScaffoldMessenger.of(context).clearSnackBars();
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Deallocate all the users before you delete the Mess")));
                            }
                            else
                          {
                showDialog(
            context: context,
              builder: (BuildContext context) {
                return AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Are you sure you want to delete this Mess?"),
            actions: [
             TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
                    ),
        TextButton(
          onPressed: (){
                  //remove the mess 
                  databaseref.child("Messes/${keys[index]}").remove();
                  onentry();
                  Navigator.of(context).pop();
                  },
          child: const Text("Confirm"),
        ),
      ],
    );
  },
); 
}  
  }, label:const Text("Delete",style: TextStyle(color: Colors.white),),
                          icon: const Icon(Icons.delete),
                          ),
                      const SizedBox(height: 5,)
                     ],
                      ),
                      const SizedBox(height: 4,)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }