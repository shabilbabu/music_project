import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_project/Screens/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteData with ChangeNotifier{
  static ValueNotifier<List> favouritesong = ValueNotifier([]);
  static List favouritelist = [];
  static List<SongModel> favsongmodellist = [];
  static List<dynamic> listDB=[];

  static addfavouritesong(value) async {
    final favDB = await Hive.openBox('fav_db');
    await favDB.add(value);
    getfavouritelist();
  }

  static getfavouritelist() async {
    final favDB = await Hive.openBox('fav_db');
    listDB = favDB.values.toList();
    songsshow();
  }

  static songsshow() async {
    final favDB = await Hive.openBox('fav_db');
    favouritesong.value.clear();
    favsongmodellist.clear();
    for (int i = 0; i < listDB.length; i++) {
      for (int j = 0; j < HomeScreen.songs.length; j++) {
        if (HomeScreen.songs[j].id == listDB[i]) {
          favouritesong.value.add(j);
          favsongmodellist.add(HomeScreen.songs[j]);
        }
      }
    }
    favouritesong.notifyListeners();
  }

  static removelist(index) async {
    final favDB = await Hive.openBox('fav_db');
    await favDB.deleteAt(index);
    getfavouritelist();
  }
}
