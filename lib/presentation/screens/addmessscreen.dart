import 'package:flutter/material.dart';
import 'package:messmanager/data/models/mess.dart';
import 'package:firebase_database/firebase_database.dart';

class AddMessScreen extends StatefulWidget
{
  const AddMessScreen({super.key,required this.database});
  final FirebaseDatabase database;
 
 @override
  State<AddMessScreen> createState() {
    return _AddMessScreen();
  }
}
//1st 
class _AddMessScreen extends State<AddMessScreen>
{
Mess enteredmess=Mess(title: "",
 menu: {
  Days.monday: DayMenu(
          breakfast: "Idli, Vada, Sambhar, Chutney, Bread Jam",
           lunch: "Rice, Chapathi, Sambhar, Dal, Kolapuri, and Many moreee",
            supper: "Samasa, sauce, Tea, Sugar, coffee",
             dinner: "Rice, chapathi, dal, gobi munchurian, dal tadka, and other stuufsss"
             ),
             Days.tuesday: DayMenu(
          breakfast: "Idli, Vada, Sambhar, Chutney, Bread Jam",
           lunch: "Rice, Chapathi, Sambhar, Dal, Kolapuri, and Many moreee",
            supper: "Samasa, sauce, Tea, Sugar, coffee",
             dinner: "Rice, chapathi, dal, gobi munchurian, dal tadka, and other stuufsss"
             ),
             Days.wednesday: DayMenu(
          breakfast: "Idli, Vada, Sambhar, Chutney, Bread Jam",
           lunch: "Rice, Chapathi, Sambhar, Dal, Kolapuri, and Many moreee",
            supper: "Samasa, sauce, Tea, Sugar, coffee",
             dinner: "Rice, chapathi, dal, gobi munchurian, dal tadka, and other stuufsss"
             ),
             Days.thursday: DayMenu(
          breakfast: "Idli, Vada, Sambhar, Chutney, Bread Jam",
           lunch: "Rice, Chapathi, Sambhar, Dal, Kolapuri, and Many moreee",
            supper: "Samasa, sauce, Tea, Sugar, coffee",
             dinner: "Rice, chapathi, dal, gobi munchurian, dal tadka, and other stuufsss"
             ),
             Days.friday: DayMenu(
          breakfast: "Idli, Vada, Sambhar, Chutney, Bread Jam",
           lunch: "Rice, Chapathi, Sambhar, Dal, Kolapuri, and Many moreee",
            supper: "Samasa, sauce, Tea, Sugar, coffee",
             dinner: "Rice, chapathi, dal, gobi munchurian, dal tadka, and other stuufsss"
             ),
             Days.saturday: DayMenu(
          breakfast: "Idli, Vada, Sambhar, Chutney, Bread Jam",
           lunch: "Rice, Chapathi, Sambhar, Dal, Kolapuri, and Many moreee",
            supper: "Samasa, sauce, Tea, Sugar, coffee",
             dinner: "Rice, chapathi, dal, gobi munchurian, dal tadka, and other stuufsss"
             ),
             Days.sunday: DayMenu(
          breakfast: "Idli, Vada, Sambhar, Chutney, Bread Jam",
           lunch: "Rice, Chapathi, Sambhar, Dal, Kolapuri, and Many moreee",
            supper: "Samasa, sauce, Tea, Sugar, coffee",
             dinner: "Rice, chapathi, dal, gobi munchurian, dal tadka, and other stuufsss"
             ),
}, number: 0, occupied: 0, vegnonveg: "none", perdaycost: 0);
void showMessentrySheet(Days day)
{
   showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: double.infinity,
        color: const Color.fromARGB(255, 223, 222, 222),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Form(
            child:Column(
              children: [
                Text(day.name.toString()),
                TextFormField(
                  onChanged: (value) 
                  {
                    enteredmess.menu[day]!.breakfast = value;
                  },
                  decoration: const InputDecoration(label: Text("Breakfast"))
                ),
                const SizedBox(height: 7,),
                  TextFormField(
                    onChanged: (value) {
                    enteredmess.menu[day]!.lunch = value;
                  },
                  decoration: const InputDecoration(label: Text("Lunch"))
                ),
                const SizedBox(height: 7,),
                TextFormField(
                  onChanged: (value) {
                    enteredmess.menu[day]!.supper = value;
                  },
                  decoration: const InputDecoration(label: Text("Snacks"))
                ),
                const SizedBox(height: 7,),
                TextFormField(
                  onChanged: (value) {
                    enteredmess.menu[day]!.dinner = value;
                  },
                  decoration: const InputDecoration(label: Text("Dinner"))
                ),
                const SizedBox(height: 7,),      
              ],
             ) 
           ),
        ),
      );
    },
   );
}


void pushMessToDatabase(Mess mess) {
  Map<String,dynamic> newmess = {
  "title":mess.title,
  "occupants":mess.occupied,
  "Totalnumber": mess.number,
  "vegnonveg":mess.vegnonveg,
  "perdaycost": mess.perdaycost,
  "Menu":{
    "monday":{
      "breakfast":mess.menu[Days.monday]!.breakfast,
      "lunch":mess.menu[Days.monday]!.lunch,
      "supper":mess.menu[Days.monday]!.supper,
      "dinner":mess.menu[Days.monday]!.dinner
    },
    "tuesday":{
      "breakfast":mess.menu[Days.tuesday]!.breakfast,
      "lunch":mess.menu[Days.tuesday]!.lunch,
      "supper":mess.menu[Days.tuesday]!.supper,
      "dinner":mess.menu[Days.tuesday]!.dinner
    },
    "wednesday":{
      "breakfast":mess.menu[Days.wednesday]!.breakfast,
      "lunch":mess.menu[Days.wednesday]!.lunch,
      "supper":mess.menu[Days.wednesday]!.supper,
      "dinner":mess.menu[Days.wednesday]!.dinner
    },
    "thursday":{
      "breakfast":mess.menu[Days.thursday]!.breakfast,
      "lunch":mess.menu[Days.thursday]!.lunch,
      "supper":mess.menu[Days.thursday]!.supper,
      "dinner":mess.menu[Days.thursday]!.dinner
    },
    "friday":{
      "breakfast":mess.menu[Days.friday]!.breakfast,
      "lunch":mess.menu[Days.friday]!.lunch,
      "supper":mess.menu[Days.friday]!.supper,
      "dinner":mess.menu[Days.friday]!.dinner
    },
    "saturday":{
      "breakfast":mess.menu[Days.saturday]!.breakfast,
      "lunch":mess.menu[Days.saturday]!.lunch,
      "supper":mess.menu[Days.saturday]!.supper,
      "dinner":mess.menu[Days.saturday]!.dinner
    },
    "sunday":{
      "breakfast":mess.menu[Days.sunday]!.breakfast,
      "lunch":mess.menu[Days.sunday]!.lunch,
      "supper":mess.menu[Days.sunday]!.supper,
      "dinner":mess.menu[Days.sunday]!.dinner
    },
  },
  };
  try {
    widget.database.ref().child("Messes").push().set(newmess);
    print("Mess pushed to database successfully!");
  } catch (error) {
    print("Error pushing Mess: ${error.toString()}");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter the mess details"),
      ),
            body: Padding(
              padding:const EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Form(
                  
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          enteredmess.title=value;
                        },
                      decoration: const InputDecoration(
                        hintText: "Name of the Mess"
                      ),
                      ),
                     const SizedBox(height: 5,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          enteredmess.perdaycost=int.parse(value);
                        },
                      decoration: const InputDecoration(
                        hintText: "Per-day cost"
                      ),
                      ),
                     const SizedBox(height: 5,),
                     TextFormField(
                       keyboardType: TextInputType.number,
                        onChanged: (value) {
                          enteredmess.number=int.parse(value);
                        },
                      decoration: const InputDecoration(
                        hintText: "Total occupants"
                      ),
                      ),
                      const SizedBox(height: 5,),
                      DropdownMenu(
                        onSelected: (value){
                          enteredmess.vegnonveg=value==1? "veg":"non-veg";
                        },
                        hintText: "select veg or non-veg",
                        dropdownMenuEntries:const [
                          DropdownMenuEntry(value: 1, label: "veg"),
                          DropdownMenuEntry(value: 2, label: "Non-veg"),
                        ] ),
                     const Text("Enter the Menu items"),
                     Card(
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                             Text(Days.monday.name),
                            const Spacer(),
                            TextButton(onPressed: (){
                              showMessentrySheet(Days.monday);
                            }, child: const Text("Enter"))
                          ],
                        ),
                      ),
                     ),
                     Card(
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                           Text(Days.tuesday.name),
                            const Spacer(),
                            TextButton(onPressed: (){
                              showMessentrySheet(Days.tuesday);
                            }, child: const Text("Enter"))
                          ],
                        ),
                      ),
                     ),
                     Card(
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                           Text(Days.wednesday.name),
                            const Spacer(),
                            TextButton(onPressed: (){
                              showMessentrySheet(Days.wednesday);
                            }, child: const Text("Enter"))
                          ],
                        ),
                      ),
                     ),
                     Card(
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                             Text(Days.thursday.name),
                            const Spacer(),
                            TextButton(onPressed: (){
                              showMessentrySheet(Days.thursday);
                            }, child: const Text("Enter"))
                          ],
                        ),
                      ),
                     ),
                     Card(
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                             Text(Days.friday.name),
                            const Spacer(),
                            TextButton(onPressed: (){
                              showMessentrySheet(Days.friday);
                            }, child: const Text("Enter"))
                          ],
                        ),
                      ),
                     ),
                     Card(
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                             Text(Days.saturday.name),
                            const Spacer(),
                            TextButton(onPressed: (){
                              showMessentrySheet(Days.saturday);
                            }, child: const Text("Enter"))
                          ],
                        ),
                      ),
                     ),
                     Card(
                      margin: const EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                             Text(Days.sunday.name),
                            const Spacer(),
                            TextButton(onPressed: (){
                              showMessentrySheet(Days.sunday);
                            }, child: const Text("Enter"))
                          ],
                        ),
                      ),
                     ),  
                    const SizedBox(height: 7,),
                   OutlinedButton(
                     onPressed: (){
                   //   final messreference = database.child("messes");
                    //  final messmenureference = database.child("messes").()
                   //   Map<String,dynamic> newMesses= enteredmess.toJson();
                   // await database.child("messes").push().set(newMesses);
                     pushMessToDatabase(enteredmess);
                      Navigator.of(context).pop(enteredmess);
                     },
                      child:const Text("Save")
                      )
              ]
            )
          ),
        ),
      ),
    );
  }
}