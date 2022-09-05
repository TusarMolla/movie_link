import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/common_ui.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/my_theme.dart';

class MovieGridItem extends StatefulWidget {
  final String imageLink, title, ratting, category;

  const MovieGridItem(
      {Key key, this.imageLink, this.title, this.ratting, this.category})
      : super(key: key);

  @override
  State<MovieGridItem> createState() => _MovieGridItemState();
}

class _MovieGridItemState extends State<MovieGridItem>
    with SingleTickerProviderStateMixin {
  int size = 50;
  Animation<double> animation; //animation variable for circle 1
  AnimationController
      animationcontroller; //animation controller variable circle 1

  changeSize() async {
    size++;

    if (size >= 50) {
      size = 0;
    }
    setState(() {});
  }

  @override
  void initState() {
    animationcontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    //here we have to vash vsync argument, there for we use "with SingleTickerProviderStateMixin" above
    //vsync is the ThickerProvider, and set duration of animation

    animationcontroller.repeat();
    //repeat the animation controller

    animation = Tween<double>(begin: 35, end: 50).animate(animationcontroller);
    //set the begin value and end value, we will use this value for height and width of circle

    animation.addListener(() {
      setState(() {});
      //set animation listiner and set state to update UI on every animation value change
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              height: animation.value,
              width: animation.value,
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
    );
  }
}
