import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String text,imageLink;
  const CategoryItem({Key key, this.text, this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
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
                color: Colors.black45,
              ),
              child: Text(text??"",style: TextStyle(fontSize: 15,color: Colors.white,),textAlign:TextAlign.center ,))
        ],
      ),
    );
  }
}
