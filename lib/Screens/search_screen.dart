import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_project/Screens/home_screen.dart';
import 'package:music_project/Screens/play_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static dynamic searchindex = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Scaffold(
          
          backgroundColor: Colors.transparent,
          appBar: 
           AppBar(
              backgroundColor: Colors.transparent,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: TextField(
                onChanged: (String?  value){
                  if(value == null || value.isEmpty){
                    temp.value.addAll(HomeScreen.songs);
                  }else{
                    temp.value.clear();
                    for(SongModel ind in HomeScreen.songs){
                      if(ind.title.toLowerCase().contains(value.toLowerCase())){
                        temp.value.add(ind);
                      }
                    }
                  }
                  temp.notifyListeners();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  prefixIcon: const Icon(Icons.search_rounded,size: 25,color: Colors.black,),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search Songs',
                ),
              ),
            ),
           
            
            
          ), 
          
          body: SafeArea(
            
              child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height:MediaQuery.of(context).size.height *1,
                    child: ValueListenableBuilder(
                        valueListenable: temp,
                        builder: (BuildContext context, List<SongModel> searchdata,
                            Widget? child) {
                          return ListView.builder(
                              itemCount: searchdata.length,
                              itemBuilder: (context, index) {
                                final data = searchdata[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    height: 50,
                                    child: ListTile(
                                      leading: QueryArtworkWidget(
                                          artworkWidth: 50,
                                          artworkBorder: BorderRadius.circular(800),
                                          artworkFit: BoxFit.cover,
                                          id: data.id,
                                          type: ArtworkType.AUDIO),
                                      title: Text(
                                        data.title,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      onTap: () async {
                                        await HomeScreen.player.play();
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => const PlayScreen()));
    
                                        int songindex =
                                            indexpassing(searchdata, index);
                                        await HomeScreen.player
                                          .setAudioSource(
                                              createPlaylist(HomeScreen.songs),
                                              initialIndex: songindex);
                                        
                                       
                                            
                                      },
                                    ),
                                  ),
                                );
                              });
                        }),
                  )
                ],
              )
            ],
          ))
        ),
      ),
    );
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(
        song.uri!,
      )));
    }
    return ConcatenatingAudioSource(children: sources);
  }
}

indexpassing(data, index) {
  int? searchindex;
  for (int i = 0; i < HomeScreen.songs.length; i++) {
    if (data[index].id == HomeScreen.songs[i].id) {
      searchindex = i;
    }
  }
  return searchindex;
}
