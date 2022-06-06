import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_project/db/data_model.dart';

class PlayFunction{
  static ValueNotifier<List<MusicModel>> listplaysong = ValueNotifier([]);

  static addplaylist({required MusicModel model}) async {
    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');
    await playlistDB.add(model);
  }

  static displayplaylist ()async{
     final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');
     listplaysong .value.clear();
     listplaysong.value.addAll(playlistDB.values);
     print('hey...............${listplaysong.value[0].name}');
     listplaysong.notifyListeners();
  }
}