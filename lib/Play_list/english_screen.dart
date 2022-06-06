import 'package:flutter/material.dart';
import 'package:music_project/Play_list/play_list_function.dart';

class EnglishScreen extends StatefulWidget {
  EnglishScreen({Key? key,required this.folderindex}) : super(key: key);
  int? folderindex;
  @override
  State<EnglishScreen> createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen> {
  @override
  Widget build(BuildContext context) {
    PlayFunction.displayplaylist();
    return Container(
      decoration:  const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.black,
          Color.fromARGB(255, 165, 165, 165),
          ])
      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,

          backgroundColor: Colors.transparent,
          title:  Text(PlayFunction.listplaysong.value[widget.folderindex!].name.toString(),
          style: TextStyle(fontFamily: 'colonnamt',fontSize: 30),),
        ),
        body: 
        ValueListenableBuilder(
          valueListenable: PlayFunction.listplaysong,
          builder: (BuildContext context, dynamic value, Widget? child) {
            return ListView.builder(
          itemCount: PlayFunction.listplaysong.value[widget.folderindex!].songlistdb.length,
          itemBuilder: (BuildContext context, int indext){
            return 
          
             ListTile(
              title: const Text('',style: TextStyle(color: Colors.white),),
              subtitle: const Text('',style: TextStyle(color: Colors.white,),),
              trailing: Icon(Icons.favorite,color: Colors.white.withOpacity(0.5),size: 20,),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: const Image(image: AssetImage(''))),

            );
          });
          },
        ),
        
      ),
    );
  }
}