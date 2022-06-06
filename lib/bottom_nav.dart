import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_project/Screens/favourite_screen.dart';
import 'package:music_project/Screens/home_screen.dart';
import 'package:music_project/Play_list/playlist_screen.dart';
import 'package:music_project/Screens/search_screen.dart';
import 'package:music_project/Screens/settings_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens = [
    const SearchScreen(),
    const FavouriteScreen(),
    const HomeScreen(),
     PlaylistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.search,
        size: 20,
        color: Color.fromARGB(255, 19, 0, 0),
      ),
      const Icon(
        Icons.favorite_border_outlined,
        size: 20,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      const Icon(
        Icons.home,
        size: 30,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      const Icon(
        Icons.playlist_add,
        size: 20,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      const Icon(
        Icons.settings,

        size: 20,
        color: Color.fromARGB(255, 0, 0, 0),

        
      ),
    ];

    return 
       Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: <Color>[Color.fromARGB(255, 165, 165, 165), Color.fromARGB(255, 0, 0, 0)],
            ),
            image: DecorationImage(
              
              image: AssetImage('lib/assets/grid background.png'),
              
              
              

              fit: BoxFit.cover,
            )),
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: screens[index],
          bottomNavigationBar: CurvedNavigationBar(

            key: navigationKey,
            color: const Color.fromARGB(255, 255, 255, 255),
            buttonBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,

            animationDuration: const Duration(milliseconds: 500),
            height: 50,
            
            index: index,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
      );
    
  }
}
