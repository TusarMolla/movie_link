import 'package:flutter/material.dart';
import 'package:movie_link/custom/lang.dart';



class Favorite extends StatefulWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangText(context).getLang().favorite_page_title),),
      body: Container(
        child: Text("Favorite"),
      ),
    );
  }
}
