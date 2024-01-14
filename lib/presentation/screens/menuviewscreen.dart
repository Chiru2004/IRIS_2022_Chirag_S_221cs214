
import 'package:flutter/material.dart';
import 'package:messmanager/data/models/mess.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MenuViewScreen extends StatefulWidget
{
  MenuViewScreen({super.key,required this.mess});
final Mess mess;
@override
  State<MenuViewScreen> createState() {
return _MenuViewScreen();
  }

}

class _MenuViewScreen extends State<MenuViewScreen>
{
  PageController controller = PageController(
  initialPage: 0
);
@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Menu",style: TextStyle(color: Colors.black),),),
      body: Column(
        children: [
          Padding(
            padding:const EdgeInsets.all(3),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mess type:"+widget.mess.vegnonveg),
                  const SizedBox(height: 1,), 
                  Text("Per day cost: "+widget.mess.perdaycost.toString()),
                  const SizedBox()
                ],
              ),
            
             ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                
                  //physics: BouncingScrollPhysics(),
                controller: controller,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(9),
                  //decoration: BoxDecoration(color: Colors.orange),
                    child: Column(
                        children: [
                          Text(Days.values[index].name.toUpperCase(),style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 25),),
                          Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 5,),
                          ListTile(
                            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9)
                            )
                            ),
                            tileColor: Theme.of(context).colorScheme.primary ,
                            minLeadingWidth: 3,
                        //leading: Container(decoration:const BoxDecoration(color: Colors.purple),),
                          title: Text("Breakfast: \n ${widget.mess.menu[Days.values[index]]!.breakfast}",style: const TextStyle(color: Colors.white,fontSize: 13)),
                          ),
                        const  SizedBox(height: 7,),
                          ListTile(
                            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9)
                            )
                            ),
                            tileColor: Theme.of(context).colorScheme.primary,
                            minLeadingWidth: 5,
                           // leading: Container(decoration:const BoxDecoration(color: Colors.purple),),
                          title: Text("Lunch: \n${widget.mess.menu[Days.values[index]]!.lunch}",style: const TextStyle(color: Colors.white,fontSize: 13)),
                          ),
                          const  SizedBox(height: 7,),
                          ListTile(
                            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9)
                            )
                            ),
                            tileColor:Theme.of(context).colorScheme.primary,
                            minLeadingWidth: 3,
                         //   leading: Container(decoration:const BoxDecoration(color: Colors.purple),),
                          title: Text("Supper: \n${widget.mess.menu[Days.values[index]]!.supper}",style: const TextStyle(color: Colors.white,fontSize: 13)),
                          ),
                        const  SizedBox(height: 7,),
                          ListTile(
                            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9)
                            )
                            ),
                            tileColor:Theme.of(context).colorScheme.primary,
                            minLeadingWidth: 3,
                          //  leading: Container(decoration:const BoxDecoration(color: Colors.purple),),
                          title: Text("Dinner: \n${widget.mess.menu[Days.values[index]]!.dinner}",style: const TextStyle(color: Colors.white,fontSize: 13)),
                          ),
                       ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 7,),
          SmoothPageIndicator(
          controller: controller, // Same controller as PageView
          count: 7, // Number of dots
          effect: const WormEffect(), // Choose a dot effect
          ),
        const SizedBox(height: 20,)
        ],
      ),     
    );
  }
}