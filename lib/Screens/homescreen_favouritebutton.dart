import 'package:flutter/material.dart';

import '../db/favorites/favourite_function.dart';

class homefavorite extends StatefulWidget {
  homefavorite({Key? key,required this.id}) : super(key: key);
  dynamic id;

  @override
  State<homefavorite> createState() => _homefavoriteState();
}

class _homefavoriteState extends State<homefavorite> {
  @override
  Widget build(BuildContext context) {
    final indexfinding = FavouriteData.listDB.contains(widget.id);
    if (indexfinding == true) {
      return IconButton(
          onPressed: () async {
            final checkindex =FavouriteData.listDB.indexWhere((element)=>element == widget.id);
           await FavouriteData.removelist(checkindex);
            setState(() {});
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ));
    } else {
      return IconButton(
          onPressed: () async{
            await FavouriteData.addfavouritesong(widget.id);
            setState(() {});
          },
          icon: const Icon(
            Icons.favorite_border_outlined,
            color: Color.fromARGB(255, 255, 255, 255),
          ));
    }
  }
}