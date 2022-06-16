import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_project/Screens/customs.dart';
import 'package:music_project/Screens/splash_screen.dart';

import '../db/data_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TitleName(name: 'Settings'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            const Text(
              'Reset App',
              style: TextStyle(
                  fontFamily: 'colonnamt',
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(
              width: 80,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: IconButton(
                  onPressed: () {
                    restart().whenComplete(() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SplashScreen())));
                  },
                  icon: const Icon(
                    Icons.restart_alt_rounded,
                    size: 30,
                    color: Colors.black,
                  )),
            )
          ]),
          const Divider(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Themes',
                style: TextStyle(
                    fontFamily: 'colonnamt',
                    fontSize: 25,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(
                width: 80,
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: const Icon(
                    Icons.brush_rounded,
                    size: 30,
                    color: Colors.black,
                  )),
            ],
          ),
          Divider(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'About',
                style: TextStyle(
                    fontFamily: 'colonnamt',
                    fontSize: 25,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(
                width: 80,
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Icon(
                    Icons.app_registration,
                    size: 30,
                    color: Colors.black,
                  )),
            ],
          ),
          SizedBox(
            height: 350,
          ),
          Text(
            'Version',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '0.1',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> restart() async {
    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');
    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');
    final favDB = await Hive.openBox('fav_db');
    await playlistDB.clear();
    await playlistsongDB.clear();
    await favDB.clear();
  }
}
