import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_project/Screens/home_screen.dart';
import 'package:music_project/Screens/homescreen_favouritebutton.dart';

import 'package:music_project/Screens/splash_screen.dart';
import 'package:music_project/db/data_model.dart';

import 'package:music_project/db/favorites/favourite_button.dart';
import 'package:music_project/db/favorites/favourite_function.dart';


 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   if(!Hive.isAdapterRegistered(MusicModelAdapter().typeId)){
     Hive.registerAdapter(MusicModelAdapter());
   }
    await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  
  FavouriteData.getfavouritelist();
  
  runApp(const MyApp());
  
}

class 
MyApp extends StatelessWidget {
  const 
  MyApp({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: SplashScreen(),
      );},
      designSize: const Size(411.42857142857144, 843.4285714285714),
      );
  }
}