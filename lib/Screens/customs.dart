

import 'package:flutter/material.dart';
import 'package:music_project/Play_list/playlist_folder.dart';
import 'package:music_project/Play_list/playlist_screen.dart';
import 'package:music_project/Screens/homescreen_favouritebutton.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../db/favorites/favourite_button.dart';
import 'home_screen.dart';

class TitleName extends StatelessWidget {
  TitleName({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          name,
          style: const TextStyle(
            fontFamily: 'colonnamt',
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}

class ListTileModel extends StatelessWidget {
  ListTileModel({Key? key, required this.index, required this.songslist})
      : super(key: key);
  dynamic index;
  dynamic songslist;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(songslist[index].title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white)),
      subtitle: Text(songslist[index].artist!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white)),
      trailing: IconButton(
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 170,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Favourite',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                homefavorite(id: HomeScreen.songs[index].id),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Song Info',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            Color.fromARGB(255, 0, 0, 0),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: (BuildContext) {
                                          return Container(
                                            
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      const Radius.circular(20),
                                                  topRight:
                                                      const Radius.circular(
                                                          20)),
                                            ),
                                            child: Column(
                                              children: [
                                                
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 20),
                                                  child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      child: QueryArtworkWidget(
                                                        id: HomeScreen
                                                            .songs[index].id,
                                                        type: ArtworkType.AUDIO,
                                                        artworkBorder:
                                                            BorderRadius.circular(
                                                                200),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.white),
                                                  child: Center(
                                                      child: Text(
                                                    'Song',
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily: 'colonnamt',
                                                    ),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child: Text(
                                                    HomeScreen
                                                        .songs[index].title,
                                                        
                                                        overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'colonnamt',
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.white),
                                                  child: Center(
                                                      child: Text(
                                                    'Artist',
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily: 'colonnamt',
                                                    ),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child: Text(
                                                    HomeScreen
                                                        .songs[index].artist!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'colonnamt',
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                SizedBox(height: 30),
                                                Container(
                                                  height: 25,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.white),
                                                  child: Center(
                                                      child: Text(
                                                    'Album',
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily: 'colonnamt',
                                                    ),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                    HomeScreen
                                                        .songs[index].album!,
                                                        
                                          
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'colonnamt',
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.info),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 22,
          )),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: QueryArtworkWidget(
          id: HomeScreen.songs[index].id,
          type: ArtworkType.AUDIO,
          artworkBorder: BorderRadius.circular(150.0),
        ),
      ),
    );
  }
}

class AddRemoveButton extends StatefulWidget {
  AddRemoveButton({Key? key, required this.index}) : super(key: key);

  final dynamic index;

  @override
  State<AddRemoveButton> createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    final checkindex = PlaylistScreen.selectionList
        .indexWhere((element) => element == HomeScreen.songs[widget.index].id);
    final check = PlaylistScreen.selectionList
        .contains(HomeScreen.songs[widget.index].id);
    if (check == true) {
      return IconButton(
          onPressed: () async {
            await PlaylistScreen.selectionList.removeAt(checkindex);
            setState(() {});
          },
          icon: const Icon(
            Icons.remove_circle_outline_outlined,
            color: Colors.white,
          ));
    }
    return IconButton(
        onPressed: () {
          PlaylistScreen.selectionList.add(HomeScreen.songs[widget.index].id);
          setState(() {});
        },
        icon: const Icon(
          Icons.add_circle,
          color: Colors.white,
        ));
  }
}

class UpdateAddRemoveButton extends StatefulWidget {
  const UpdateAddRemoveButton({Key? key, required this.index})
      : super(key: key);
  final dynamic index;

  @override
  State<UpdateAddRemoveButton> createState() => _UpdateAddRemoveButtonState();
}

class _UpdateAddRemoveButtonState extends State<UpdateAddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    final check =
        PlaylistFolder.updatelist.contains(HomeScreen.songs[widget.index].id);
    if (check == true) {
      return IconButton(
          onPressed: () async {
            final checkindex = await PlaylistFolder.updatelist.indexWhere(
                (element) => element == HomeScreen.songs[widget.index].id);
            await PlaylistFolder.updatelist.removeAt(checkindex);
            setState(() {});
          },
          icon: const Icon(
            Icons.remove_circle_outline_outlined,
            color: Colors.white,
          ));
    }
    return IconButton(
        onPressed: () {
          PlaylistFolder.updatelist.add(HomeScreen.songs[widget.index].id);
          setState(() {});
        },
        icon: const Icon(
          Icons.add_circle,
          color: Colors.white,
        ));
  }
}
