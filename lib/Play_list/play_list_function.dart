import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_project/Screens/home_screen.dart';
import 'package:music_project/db/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayFunction {
  static ValueNotifier<List<MusicModel>> listplaysong = ValueNotifier([]);
  static List<SongModel> playlistsongmodel = [];
  static List<dynamic> idees = [];

  static addplaylist({required MusicModel model}) async {
    print('.....................:${model.songlistdb}');
    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');
    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');
    await playlistDB.add(model);

    var hello = model.songlistdb.toList();
    await playlistsongDB.add(hello);
    print('....................:${hello}');
    displayplaylist();
  }

  static displayplaylist() async {
    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');
    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');
    listplaysong.value.clear();
    idees.clear();

    listplaysong.value.addAll(playlistDB.values);
    var hey = playlistsongDB.values.toList();
    idees = hey;
    listplaysong.notifyListeners();
  }

  static deleteplaylist(index) async {
    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');
    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');
    await playlistDB.deleteAt(index);
    await playlistsongDB.deleteAt(index);
    await displayplaylist();
  }

  static updatePlaylist(index, MusicModel model) async {
    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');
    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');
     var hey = model.songlistdb.toList();
     await playlistDB.putAt(index,model);
     await playlistsongDB.putAt(index, hey);
     displayplaylist();
  }
}

class songCheckPlaylist {
  static ValueNotifier<List> selectsong = ValueNotifier([]);

  static showselectedsong(index) {
    final checksong = PlayFunction.idees[index];
    selectsong.value.clear();
    PlayFunction.playlistsongmodel.clear();

    for (int i = 0; i < checksong.length; i++) {
      for (int j = 0; j < HomeScreen.songs.length; j++) {
        if (HomeScreen.songs[j].id == checksong[i]) {
          selectsong.value.add(j);
          PlayFunction.playlistsongmodel.add(HomeScreen.songs[j]);

          break;
        }
      }
    }
    selectsong.notifyListeners();
  }
}
