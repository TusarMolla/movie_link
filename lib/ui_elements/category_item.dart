import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/common_ui.dart';
import 'package:movie_link/my_theme.dart';
import 'package:movie_link/presenter/main_presenter.dart';
import 'package:movie_link/screens/filtered_movies.dart';
import 'package:route_transitions/route_transitions.dart';

class CategoryItem extends StatelessWidget {
  final String text,imageLink,id;
  MainPresenter presenter;
   CategoryItem({Key key, this.text, this.imageLink,this.presenter,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 4),
      decoration: CommonUi.shdowDecoration(spreadRadius: 0),
      height: 80,
      width: 80,
      child: InkWell(
        onTap: ()async{
          presenter.fetchFilters(id);
           slideRightWidget(newPage:FilteredMovies(presenter: presenter,title: text),context: context);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(placeholder: AssetImage("assets/test.jpg"), image: NetworkImage(imageLink),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyTheme.accent_soft_color,
                ),
                child: Text(text??"",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textAlign:TextAlign.center ,maxLines: 1,))
          ],
        ),
      ),
    );
  }
}
