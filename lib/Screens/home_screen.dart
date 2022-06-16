import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_project/Screens/customs.dart';
import 'package:music_project/Screens/play_screen.dart';


import 'package:music_project/concatinating.dart';

import 'package:music_project/db/favorites/favourite_function.dart';

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
  //int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    FavouriteData.songsshow();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TitleName(name: 'Musics'),
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
              return Center(
                child: Text(
                  'No Songs',
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: 'colonnamt',
                      color: Colors.white),
                ),
              );
            }
            HomeScreen.songs = item.data!;
            return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:  EdgeInsets.only(top: 15.h, bottom: 15.h),
                    margin:  EdgeInsets.only(top: 15.h, left: 15.r, right: 16.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.5)),
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                PlayScreen(pattu: HomeScreen.songs)));
                        await HomeScreen.player.setAudioSource(
                            Concatinating.createPlaylist(item.data!),
                            initialIndex: index);
                        await HomeScreen.player.play();
                      },
                      child: ListTileModel(index: index, songslist: item.data),
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
}
