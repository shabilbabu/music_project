import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_project/Screens/splash_screen.dart';
import 'package:music_project/db/data_model.dart';


 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   if(!Hive.isAdapterRegistered(MusicModelAdapter().typeId))
   {
     Hive.registerAdapter(MusicModelAdapter());
   }


  runApp(const MyApp());
  
}

class 
MyApp extends StatelessWidget {
  const 
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: SplashScreen(),
    );
  }
}