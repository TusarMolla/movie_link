

import 'package:flutter/material.dart';

class CommonUi{

  static shdowDecoration (
      {double radius=10,double blurRadius = 8.0,double offsetX=0.0,double offsetY=8.0,double spreadRadius=-4.0}
    ){
    return  BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.6),
    blurRadius: blurRadius,
    offset: Offset(offsetX,offsetY),
    spreadRadius: spreadRadius,
    )
    ],

    );
}
  static shadowContainer(
      {double radius, Widget child, Color shadowColor=const Color.fromRGBO(249, 249, 249 ,1), double blurRadius = 8.0,double offsetX=0.0,double offsetY=20.0,double spreadRadius=8.0}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            offset: Offset(offsetX,offsetY),
            spreadRadius: spreadRadius,
          )
        ],
        
      ),
      child: child,
    );
        

  }

}