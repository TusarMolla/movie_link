import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/lang.dart';
import 'package:movie_link/dummy_data/dummy_data.dart';



class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangText(context).getLang().home_page_title),),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              child: CarouselSlider(items: List.generate(DummyData.imageList.length, (index) => ClipRRect(
                child: FadeInImage(
                  placeholder:AssetImage("assets/test.jpg") ,
                  image: NetworkImage(DummyData.imageList[index]),),
              )), options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
              )),
            )
          ],
        ),
      ),
    );
  }
}
