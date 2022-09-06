
import 'package:flutter/material.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/lang.dart';

import 'package:movie_link/ui_elements/grid_movie_item.dart';



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
      body:  RefreshIndicator(
        onRefresh: (){
          return Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(slivers:[
          SliverToBoxAdapter(
            child: buildBodyContainer(context),
          )
        ],),
      ),
    );
  }

  Container buildBodyContainer(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildTrandingMovies(),
        ],
      ),
    );
  }

  Container buildTrandingMovies() => Container(
    child: Container(
      margin: EdgeInsets.only(top: 16),
      width: DeviceInfo(context).width,
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 16),
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        //children: List.generate(DummyData.imageList.length, (index) => MovieGridItem(title:DummyData.imageList[index].title ,imageLink:DummyData.imageList[index].imageLink ,ratting:DummyData.imageList[index].ratting ,category:DummyData.imageList[index].category ,)),
      ),
    ),
  );
}
