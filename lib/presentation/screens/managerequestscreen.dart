import 'dart:convert';
//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:messmanager/data/models/requests.dart';



class AdminRequest extends StatefulWidget
{
  const AdminRequest({super.key,required this.instance});
 final FirebaseDatabase instance;
@override
  State<AdminRequest> createState() 
  {
  return _AdminRequestState();
  }
}

class _AdminRequestState extends State<AdminRequest>
{
  bool norequests = false;
bool isdatafetching =true;
List<requestdata> requests=[];
// dynamic value
int dynamichangedmess = 0;
int dynamiccurrentmess = 0;
//Function to fetch the data

void fetchtherequets() async
{
  List<requestdata> request=[];
await widget.instance.ref().child("MessRequests/Requests").get().then(
  (value){
String jsonstring = json.encode(value.value);
if(jsonstring == "null")
{
setState(() {
  norequests=true;
   isdatafetching=false;
});
}
print(jsonstring);
Map<String,dynamic> requestvalue= json.decode(jsonstring);

requestvalue.forEach((key, value) {
request.add(requestdata.fromJson(value));
}
);
 }
);
setState(() {
  requests.addAll(request);
  isdatafetching=false;
});

}



@override
  void initState() 
  {
    fetchtherequets();
    super.initState();
  }

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Request"),
      ),
      body: isdatafetching? const Center(child: CircularProgressIndicator(),):
      norequests? const Center(child: Text("No requests"),) :
      ListView.builder(
        padding:const EdgeInsets.all(7),

        itemCount: requests.length,
        itemBuilder: (context, index) {
          return Container(
          margin: const EdgeInsets.all(5),
             decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Theme.of(context).colorScheme.primary,
                width: 2
                )
              ),
            child: Padding(
              padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Request ${index+1}"),),
                const SizedBox(height: 5,),
                Text("Request from: ${requests[index].studentname}",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                const SizedBox(height: 3,),
                Text("Rollnumber: ${requests[index].studentroll}",style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 3,),
                Text("Current Mess: ${requests[index].currentmessname}",style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 3,),
                Text("Mess to change: ${requests[index].changedmessname}",style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                         showDialog(
            context: context,
              builder: (BuildContext context) {
                return AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Are you sure you want to Approve this request?"),
            actions: [
             TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
                    ),
        TextButton(
          onPressed: ()async {


                 //Delete in the MessRequests
                 widget.instance.ref().child("MessRequests/Requests/${requests[index].studentid}").remove();
                 
                 //Add in another column for results,
                 widget.instance.ref().child("MessRequests/Results/${requests[index].studentid}").set({
                  "result" : "Approved"
                 });

                 // change in messUsers
                 widget.instance.ref().child("MessUsers/${requests[index].currentmessid}/${requests[index].studentid}").remove();
                  widget.instance.ref().child("MessUsers/${requests[index].changedmessid}/${requests[index].studentid}").set({
                   "name":requests[index].studentname,
                   "roll":requests[index].studentroll
                  });

                  // change in mess numbers
                  // fetch the dynamic number,,,
                  // 
                await  widget.instance.ref().child("Messes/${requests[index].currentmessid}/occupants").once().then((value){
                  print(value.snapshot.value.toString()); //changes
                  dynamiccurrentmess=int.parse(value.snapshot.value.toString());
                });
                await  widget.instance.ref().child("Messes/${requests[index].changedmessid}/occupants").once().then((value){
                  print(value.snapshot.value.toString()); //changes
                  dynamichangedmess=int.parse(value.snapshot.value.toString());
                });
                  
                  //decrease number by one
                  widget.instance.ref().child("Messes/${requests[index].currentmessid}").update({
                    "occupants":dynamiccurrentmess-1   //dynamic data fetch
                  });

                  //increase number by one
                  widget.instance.ref().child("Messes/${requests[index].changedmessid}").update({
                    "occupants":dynamichangedmess+1    //dynamic data fetch
                  });

                  //change the mess id in the User
                  widget.instance.ref().child("Users/${requests[index].studentid}/${requests[index].studentkey}").update(
                    {
                       "mess":requests[index].changedmessid
                    }
                  );
                  setState(() {
                    dynamiccurrentmess=0;
                    dynamichangedmess=0;
                    requests=[];
                     fetchtherequets();
                  });
                 
                  Navigator.of(context).pop();

                  },
          child: const Text("Confirm"),
        ),
      ],
    );
  },
);
                      }, 
                    child: const Text("Approve")
                    ),
                    const SizedBox(width: 3,),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
            context: context,
              builder: (BuildContext context) {
                return AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Are you sure you want to reject this request?"),
            actions: [
             TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
                    ),
        TextButton(
          onPressed: (){
                   //Delete in the MessRequests
                 widget.instance.ref().child("MessRequests/Requests/${requests[index].studentid}").remove();
                 
                 //Add in another column for results,
                  widget.instance.ref().child("MessRequests/Results/${requests[index].studentid}").set({
                  "result" : "denied"
                 });
                 fetchtherequets();
                  Navigator.of(context).pop();
                  },
          child: const Text("Confirm"),
        ),
      ],
    );
  },
);
                      }, 
                    child: const Text("Reject")
                    ),
                  ],
                )
              ],
            ),
            ),
          );
        },
        )
    );
  }

}
