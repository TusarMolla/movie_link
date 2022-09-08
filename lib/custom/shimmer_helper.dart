

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/common_ui.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/my_theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper{
  static Widget slideShimmer(context){
  return  Container(
      width: DeviceInfo(context).width,
      padding: EdgeInsets.only(bottom: 10),
      //color: Colors.grey,
      decoration: CommonUi.shdowDecoration(color:Colors.grey.shade300),
      height: 100,
    );
  }

  static Widget basicShimmer({width=0.0,height=0.0,radius=0.0}){
   return Shimmer.fromColors(
      baseColor: MyTheme.shimmerBaseColor,
      highlightColor: MyTheme.shimmerHighlightColor,

      child:Container(width: width,height: height,decoration: BoxDecoration(borderRadius:BorderRadius.circular(radius), color: Colors.grey),)
    );
  }



}