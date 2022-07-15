import 'package:flutter/material.dart';
import 'package:movie_link/custom/lang.dart';



class TV extends StatefulWidget {
  const TV({Key key}) : super(key: key);

  @override
  _TVState createState() => _TVState();
}

class _TVState extends State<TV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangText(context).getLang().tv_page_title),),
      body: Container(
        child: Text("TV"),
      ),
    );
  }
}
