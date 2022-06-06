import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_project/Screens/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);
  

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  String currentSongTitle = '';
  int currentIndex = 0;
  bool shufflecheck=false;

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          HomeScreen.player.positionStream,
          HomeScreen.player.durationStream,
          (position, total) => DurationState(
              position: position, total: total ?? Duration.zero));

  @override
  void initState() {
    super.initState();
    HomeScreen.player.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Text(
                currentSongTitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Text(HomeScreen.songs[currentIndex].artist!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
            ),
        
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 300,
                height: 300,
                margin: const EdgeInsets.only(top: 40, bottom: 30),
                child: QueryArtworkWidget(
                  id: HomeScreen.songs[currentIndex].id,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(150.0),
                ),
              ),
            ),
        
            //slider , position and duration widgets
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //shuffle playlist
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              if(shufflecheck==false){
                                HomeScreen.player.setShuffleModeEnabled(true);
                                shufflecheck=true;
                                setState(() {});
                      
                              }else{
                                HomeScreen.player.setShuffleModeEnabled(false);
                                shufflecheck=false;
                                setState(() {});
                              }
                      
                            },
                            child: Builder(builder: ((context) {
                              if(shufflecheck==false){
                                return Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.only(right: 40.0, left: 10.0),
                              child: const Icon(
                                Icons.shuffle,
                                size: 20,
                                color: Colors.white,
                              ),
                            );
                              }else{
                                return Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.only(right: 40.0, left: 10.0),
                              child: const Icon(
                                Icons.shuffle,
                                size: 20,
                                color: Color.fromARGB(255, 255, 0, 0),
                              ),
                            );
                              }
                            }))
                          ),
                        ),
                        Flexible(
                            child: InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(right: 40.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          ),
                        )),
                        // repeat mode
                        Flexible(
                            child: InkWell(
                          onTap: () {
                            HomeScreen.player.loopMode == LoopMode.one
                                ? HomeScreen.player.setLoopMode(LoopMode.all)
                                : HomeScreen.player.setLoopMode(LoopMode.one);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: StreamBuilder<LoopMode>(
                                stream: HomeScreen.player.loopModeStream,
                                builder: (context, snapshot) {
                                  final loopMode = snapshot.data;
                                  if (LoopMode.one == loopMode) {
                                    return const Icon(
                                      Icons.repeat_one,
                                      size: 20,
                                      color: Colors.red,
                                    );
                                  }
                                  return const Icon(
                                    Icons.repeat,
                                    size: 20,
                                    color: Colors.white,
                                  );
                                },
                              )),
                        )),
                      ],
                    )),
                //slider bar container
                Container(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  //slider bar duration state stream
                  child: StreamBuilder<DurationState>(
                    stream: _durationStateStream,
                    builder: (context, snapshot) {
                      final durationState = snapshot.data;
                      final progress = durationState?.position ?? Duration.zero;
                      final total = durationState?.total ?? Duration.zero;
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: ProgressBar(
                          progress: progress,
                          total: total,
                          barHeight: 3,
                          thumbRadius: 7,
                          baseBarColor: const Color.fromARGB(255, 147, 147, 147),
                          progressBarColor: const Color.fromARGB(255, 255, 255, 255),
                          thumbColor: const Color.fromARGB(153, 255, 255, 255),
                          timeLabelLocation: TimeLabelLocation.sides,
                          timeLabelPadding: 3,
                          timeLabelTextStyle: const TextStyle(),
                          onSeek: (duration) {
                            HomeScreen.player.seek(duration);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        
            // prev, play/pause & seek next control buttons
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //skip to previous
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        if (HomeScreen.player.hasPrevious) {
                          HomeScreen.player.seekToPrevious();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(10.0),
                        child: const Icon(
                          Icons.skip_previous,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  //play pause
                  Flexible(
                    child: InkWell(
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
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100)),
                        child: StreamBuilder<bool>(
                          stream: HomeScreen.player.playingStream,
                          builder: (context, snapshot) {
                            bool? playingState = snapshot.data;
                            if (playingState != null && playingState) {
                              return const Icon(
                                Icons.pause,
                                size: 50,
                                color: Colors.white,
                              );
                            }
                            return const Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: Colors.black,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
        
                  //skip to next
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        if (HomeScreen.player.hasNext) {
                          HomeScreen.player.seekToNext();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(10.0),
                        child: const Icon(
                          Icons.skip_next,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
            //go to  shuffle , repeat all and repeat one control buttons
          ],
        ),
      ),
    );
  }

  void _updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (HomeScreen.songs.isNotEmpty) {
        currentSongTitle = HomeScreen.songs[index].title;
        currentIndex = index;
      }
    });
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
