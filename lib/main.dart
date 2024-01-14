import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messmanager/presentation/screens/loginscreen.dart';
import 'package:messmanager/presentation/screens/splashscreen.dart';
import 'package:messmanager/presentation/screens/usermenu.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.flu
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         textTheme: TextTheme(
          labelMedium: GoogleFonts.lato(),
          titleMedium: GoogleFonts.lato(),
           bodyMedium: GoogleFonts.lato() 
         ),
        colorScheme: ColorScheme.fromSeed(
         primary:const Color.fromARGB(255, 85, 14, 14), 
          seedColor:Colors.red ),
        useMaterial3: true,
      ),
      home:controllerPage()
      
    
    );
  }
}

class controllerPage extends StatelessWidget
{
 
 @override
  Widget build(BuildContext context) {
   return 
    StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const SplashScreen();
          }
          if(snapshot.hasData)
          {
           // print(snapshot.data!.uid);
            return  UserMenu(id: snapshot.data!.uid,);
          }
          return LoginScreen();
        },);
        
  }
}