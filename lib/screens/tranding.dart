import 'package:flutter/material.dart';
import 'package:movie_link/custom/lang.dart';



class Tranding extends StatefulWidget {
  const Tranding({Key key}) : super(key: key);

  @override
  _TrandingState createState() => _TrandingState();
}

class _TrandingState extends State<Tranding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangText(context).getLang().tranding_page_title),),
      body: Container(
        child: Text("Tranding"),
      ),
    );
  }
}
