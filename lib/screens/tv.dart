
import 'package:flutter/material.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/lang.dart';
import 'package:movie_link/custom/shimmer_helper.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/presenter/main_presenter.dart';
import 'package:movie_link/ui_elements/grid_movie_item.dart';



class TV extends StatefulWidget {
  MainPresenter presenter;
   TV({Key key,this.presenter}) : super(key: key);

  @override
  _TVState createState() => _TVState();
}

class _TVState extends State<TV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text(LangText(context).getLang().tv_page_title),),
      body: buildBodyContainer(context),
    );
  }
  Widget buildBodyContainer(BuildContext context) {
    return buildTrandingMovies();
  }


  Widget buildTrandingMovies() => StreamBuilder<MoviesResponse>(
      stream: widget.presenter.tvShows,
      builder: (context, snapshot) {
         if(snapshot.hasData)
          return Container(
              alignment: Alignment.center,
              child: GridView.count(
                padding: EdgeInsets.only(right: 16, left: 16, top: 10,bottom: 60),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
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
            );
          else
           return buildTopMovieShimmer(context);

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