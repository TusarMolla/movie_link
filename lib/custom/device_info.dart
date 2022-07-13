

import 'package:flutter/cupertino.dart';

class DeviceInfo{
  BuildContext context;
  double height,width;
  DeviceInfo(BuildContext context) {
    this.context=context;
    this.height=MediaQuery.of(context).size.height;
    this.width=MediaQuery.of(context).size.width;
  }
}