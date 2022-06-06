

import 'package:flutter/material.dart';
import 'package:music_project/Play_list/english_screen.dart';
import 'package:music_project/Play_list/play_list_function.dart';

import 'package:music_project/db/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Screens/home_screen.dart';

class PlaylistScreen extends StatefulWidget {
   PlaylistScreen({Key? key}) : super(key: key);

  final namecontroller = TextEditingController();
 final List<dynamic> selectionList = [];

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    PlayFunction.displayplaylist();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Playlist',
              style: TextStyle(fontFamily: 'colonnamt', fontSize: 35),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.black,
                                Color.fromARGB(255, 165, 165, 165),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, right: 20, left: 20),
                                  child: TextField(
                                    controller: widget.namecontroller,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              final foldername = widget.namecontroller.text;
                                              
                                             final modelM =  MusicModel(name: foldername,songlistdb: widget.selectionList);
                                              
                                              PlayFunction.addplaylist(model: modelM);
                                              
                                                Navigator.pop(context);
                                              
                                            },
                                            child: const Icon(
                                              Icons.save,
                                              color: Colors.black,
                                              size: 30,
                                            )),
                                        hintText: '    Create Playlist',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: ListView.separated(
                                        itemCount: HomeScreen.songs.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(
                                                  color: Colors.white,
                                                  indent: 18,
                                                  endIndent: 18,
                                                  height: 20,
                                                ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(
                                              HomeScreen.songs[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              HomeScreen
                                                  .songs[index].displayName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            trailing:  IconButton(onPressed: (){
                                              widget.selectionList.add(HomeScreen.songs[index].id);

                                            }, icon: Icon(Icons.add_circle_outline)),
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                              child: QueryArtworkWidget(
                                                id: HomeScreen.songs[index].id,
                                                type: ArtworkType.AUDIO,
                                                artworkBorder:
                                                    BorderRadius.circular(
                                                        150.0),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Icon(
                  Icons.note_add_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        preferredSize: const Size.fromHeight(80),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: ValueListenableBuilder(
          valueListenable: PlayFunction.listplaysong,
          
          builder: (BuildContext context, dynamic value, Widget? child) {
            return  GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: PlayFunction.listplaysong.value.length,
          itemBuilder: (BuildContext context, index) {
            
            return InkWell(
              onTap: () {
                
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EnglishScreen(folderindex: index)));
                
              },
              child: Card(
                color: Colors.white,
                child: Text(PlayFunction.listplaysong.value[index].name.toString()),
              ),
            );
             
          },
        ); 
          },
        ),
        
      ),
    );
  }
}
