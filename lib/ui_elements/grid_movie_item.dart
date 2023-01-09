
import 'package:flutter/material.dart';
import 'package:movie_link/custom/common_ui.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/my_theme.dart';
import 'package:movie_link/presenter/main_presenter.dart';
import 'package:movie_link/screens/movie_details.dart';
import 'package:route_transitions/route_transitions.dart';

class MovieGridItem extends StatefulWidget{
  final MainPresenter presenter;
  final String imageLink, title, ratting, category,id;
  int index;

   MovieGridItem({Key key,this.index, this.imageLink, this.title, this.ratting, this.category, this.presenter, this.id}) : super(key: key);

  @override
  State<MovieGridItem> createState() => _MovieGridItemState();
}

class _MovieGridItemState extends State<MovieGridItem>{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //print("add click");
        //_interstitialAd.show();
        if (widget.presenter.isInterstitialAdReady) {
          widget.presenter.interstitialAd.show();
        }
        widget.presenter.fetchMovieDetails(widget.id);
        slideRightWidget(newPage: MovieDetails(mainPresenter: widget.presenter,id: widget.id,), context: context);
      },
      child: Container(
        decoration: CommonUi.shdowDecoration(spreadRadius: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            // fit: StackFit.passthrough,
            children: [
              FadeInImage(
                placeholder: AssetImage("assets/place_holder.jpg"),
                image: NetworkImage(widget.imageLink),
                height: 150,
                width: DeviceInfo(context).width / 2,
                fit: BoxFit.cover,
              ),
              Container(
                  height: 50,
                  width: DeviceInfo(context).width / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyTheme.accent_soft_color,
                  ),
                  child: Text(
                    widget.title ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  )),
              /*Center(
                      child: Container(
                        alignment: Alignment.center,
                        transformAlignment: Alignment.center,
                        height: snapshot.data,
                        width: snapshot.data,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(1, 5),
                              spreadRadius: 2,
                            ),
                          ],
                          color: MyTheme.ambr,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          size: 35,
                          color: MyTheme.white,
                        ),
                      )),*/
            ],
          ),
        ),
      ),
    );
  }
}

