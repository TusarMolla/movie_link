import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/common_ui.dart';
import 'package:movie_link/custom/device_info.dart';

class MovieGridItem extends StatelessWidget {
  final String imageLink, title, ratting, category;

  const MovieGridItem(
      {Key key, this.imageLink, this.title, this.ratting, this.category})
      : super(key: key);

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
              image: NetworkImage(imageLink),
              height: 200,
              width: DeviceInfo(context).width / 2,
              fit: BoxFit.cover,
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    height: 50,
                    width: DeviceInfo(context).width/2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                    ),
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
            Center(
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.8),
                  child:
                  Icon(
                    Icons.play_circle_filled,
                    color: Colors.black.withOpacity(0.6),
                    size: 50,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
