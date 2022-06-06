import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_project/Screens/play_screen.dart';

import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  static final AudioPlayer player = AudioPlayer();
  static List<SongModel> songs = [];

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    storageRequestpermission();
  }

  // String currentSongTitle = '';
  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'My Musics',
              style: TextStyle(
                fontFamily: 'colonnamt',
                fontSize: 35,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
      
            if (item.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Songs',
                  style: TextStyle(fontSize: 22, fontFamily: 'colonnamt',color: Colors.white),
                ),
              );
            }
            HomeScreen.songs = item.data!;
            return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.5)),
                    child: InkWell(
                      onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const PlayScreen()));
                          await HomeScreen.player.setAudioSource(
                              createPlaylist(item.data!),
                              initialIndex: index);
                          await HomeScreen.player.play();
                        },
                        
                      child: ListTile(
                        title: Text(item.data![index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(item.data![index].artist!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white)),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: QueryArtworkWidget(
                  id: HomeScreen.songs[index].id,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(150.0),
                ),),
                        trailing: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  void storageRequestpermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: sources);
  }
  

  
  
}

