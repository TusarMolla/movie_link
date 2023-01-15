
import 'package:flutter/material.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/lang.dart';
import 'package:movie_link/custom/shimmer_helper.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/presenter/main_presenter.dart';

import 'package:movie_link/ui_elements/grid_movie_item.dart';



class Tranding extends StatefulWidget {
  MainPresenter presenter;
   Tranding({Key key,this.presenter}) : super(key: key);

  @override
  _TrandingState createState() => _TrandingState();
}

class _TrandingState extends State<Tranding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text(LangText(context).getLang().tranding_page_title),),
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


  Widget buildTrandingMovies() => StreamBuilder<MoviesResponse>(
      stream: widget.presenter.trandingMovies,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 16),
          width: DeviceInfo(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(snapshot.hasData)
                Container(
                  alignment: Alignment.center,
                  child: GridView.count(
                    padding: EdgeInsets.only(right: 16, left: 16, bottom: 60),
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: List.generate(
                        snapshot.data.data.length,
                            (index) => MovieGridItem(
                          title: snapshot.data.data[index].name,
                          imageLink: snapshot.data.data[index].image,
                          ratting: snapshot.data.data[index].rating,
                          category: snapshot.data.data[index].category,
                          presenter: widget.presenter,
                          id:snapshot.data.data[index].id.toString() ,
                          index: index,
                        )),
                  ),
                )
              else
                buildTopMovieShimmer(context),

            ],
          ),
        );
      });

  Widget buildTopMovieShimmer(context) => Container(
    alignment: Alignment.center,
    child: GridView.count(
      padding: EdgeInsets.only(right: 16, left: 16, bottom: 60),
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.8,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      children: List.generate(
          10,
              (index) => ShimmerHelper.basicShimmer(
              height: 200.0,
              width: DeviceInfo(context).width / 2,
              radius: 10.0
          )),
    ),
  );

}
