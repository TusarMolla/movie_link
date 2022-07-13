import 'package:flutter/material.dart';
import 'package:movie_link/custom/device_info.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              height: 300,
              width: DeviceInfo(context).width,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadiusDirectional.only(topStart:Radius.elliptical(6, 6),topEnd: Radius.elliptical(6, 6),bottomStart: Radius.elliptical(6, 6),bottomEnd: Radius.circular(60)),

              ),
              child: Icon(Icons.play_circle_filled,size: 80,color: Colors.amber,),
            )
          ],
        ),
      ),
    );
  }
}
