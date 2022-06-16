import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_project/Screens/play_screen.dart';
import 'package:music_project/db/favorites/favourite_screen.dart';
import 'package:music_project/Screens/home_screen.dart';
import 'package:music_project/Play_list/playlist_screen.dart';
import 'package:music_project/Screens/search_screen.dart';
import 'package:music_project/Screens/settings_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Color.fromARGB(255, 233, 233, 233),
              Color.fromARGB(255, 0, 0, 0)
            ],
          ),
          image: DecorationImage(
            image: AssetImage('lib/assets/grid background.png'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: screens[index],
        bottomNavigationBar: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: CurvedNavigationBar(
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
          Positioned(
            child: HomeScreen.player.currentIndex != null ||
                    HomeScreen.player.playing
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      
                    ),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                setState(() {});
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PlayScreen(pattu: HomeScreen.songs)));
                              },
                              title: 
                                  Text(
                                    PlayScreen.minilist[HomeScreen.player.currentIndex!]
                                        .title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  trailing: InkWell(
                      onTap: () {
                        if (HomeScreen.player.playing) {
                          HomeScreen.player.pause();
                        } else {
                          if (HomeScreen.player.currentIndex != null) {
                            HomeScreen.player.play();
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100)),
                        child: StreamBuilder<bool>(
                          stream: HomeScreen.player.playingStream,
                          builder: (context, snapshot) {
                            bool? playingState = snapshot.data;
                            if (playingState != null && playingState) {
                              return const Icon(
                                Icons.pause,
                                size: 30,
                                color: Colors.white,
                              );
                            }
                            return const Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            );
                          },
                        ),
                      ),
                    ),
                                    
                                    
                                 
                               
                              leading: QueryArtworkWidget(
                                  id: PlayScreen
                                      .minilist[HomeScreen.player.currentIndex!].id,
                                  type: ArtworkType.AUDIO),
                                  

                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(height: 0,),
          ),
        ]),
      ),
    );
  }
}
