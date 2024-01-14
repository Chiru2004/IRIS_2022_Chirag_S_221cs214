import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class MyFormDialog extends StatefulWidget {
MyFormDialog(
  {
  super.key,
  required this.studentid, 
  required this.studentkey,
  required this.instance,
  required this.currentbalance
  });

String studentid;
String studentkey;
FirebaseDatabase instance;
int currentbalance;
    @override
    _MyFormDialogState createState() => _MyFormDialogState();
}

class _MyFormDialogState extends State<MyFormDialog> {
   int finalamount=0;

    // ... other fields and methods

    @override
    Widget build(BuildContext context) {
        return AlertDialog(
            title: const Text('Add messbalance'),
            content: Form(
               
             child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration( labelText: "New Mess balance"),
                        keyboardType: TextInputType.number ,
                        onChanged: (value) {
                          finalamount= int.parse(value);
                        },
                      ),
                      const SizedBox(height: 3,),
                        // Add your form fields here (TextFormField, DropdownButtonFormField, etc.)
                        ElevatedButton(
                            onPressed: () async{
                                
                                    // Process form data
                                     await widget.instance.ref().child("Users/${widget.studentid}/${widget.studentkey}").update({
                            "messbalance":finalamount+widget.currentbalance
                               });
                                    Navigator.of(context).pop();
                                
                            },
                            child: const Text('Submit'),
                        ),
                    ],
                ),
            ),
        );
    }
}