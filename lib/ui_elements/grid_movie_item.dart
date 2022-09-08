
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
    return StreamBuilder<double>(
      stream: widget.presenter.getAnimationValue,
      builder: (context, snapshot) {
        return InkWell(
          onTap: (){
            print("object");
            widget.presenter.fetchMovieDetails(widget.id);
            Navigator.push(context, PageRouteTransition(
                animationType: AnimationType.slide_right,
                builder: (context)=>MovieDetails(mainPresenter: widget.presenter,)));

          },
          child: Container(
            decoration: CommonUi.shdowDecoration(spreadRadius: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  FadeInImage(
                    placeholder: AssetImage("assets/test.jpg"),
                    image: NetworkImage(widget.imageLink),
                    height: 200,
                    width: DeviceInfo(context).width / 2,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
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
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ))),
                  Center(
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
                      )),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

