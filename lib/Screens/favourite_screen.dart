import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Favourite Songs',
              style: TextStyle(fontFamily: 'colonnamt', fontSize: 35),
            ),
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.only(top: 20),

        child: ListView.separated(
          itemCount: 25,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 1,
            indent: 90,
            endIndent: 18,
            color: Colors.white,
            
          ),
          itemBuilder: (BuildContext context, int index) {
            return  ListTile(
              title: const Text('"Kun_Faya_Kun_Rockstar"_(Official_full_vidio...',style: TextStyle(color: Colors.white),),
              subtitle: const Text('<unknowns>_downloads',style: TextStyle(color: Colors.white),),
              trailing: const Icon(Icons.more_vert_outlined,color: Colors.white,),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: const Image(
                  image: AssetImage('lib/assets/Untitled-2.jpg'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
