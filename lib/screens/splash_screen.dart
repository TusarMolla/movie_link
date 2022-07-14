import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/lang.dart';
import 'package:movie_link/screens/main.dart';
import 'package:route_transitions/route_transitions.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainPage()), (route) => false);
    });
    // TODO: implement initState
    super.initState();
  }
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
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade200,
                    Colors.blue.shade300,
                    Colors.blue.shade400,
                    Colors.blue.shade500,
                    Colors.blue.shade600,
                    Colors.blue.shade700,
                  ]
                )
              ),
              child: Icon(Icons.play_circle_filled,size: 80,color: Colors.amber,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
              child: Text(LangText(context).getLang().splash_screen_text1,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,height: 1.5),textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 4),
              child: Text(LangText(context).getLang().splash_screen_click,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,height: 1.5),textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 4),
              child: Text(LangText(context).getLang().splash_screen_watch,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,height: 1.5),textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 4),
              child: Text(LangText(context).getLang().splash_screen_enjoy,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,height: 1.5),textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 60,
              width: DeviceInfo(context).width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.pink.shade500,
                      Colors.pink.shade600,
                      Colors.pink.shade700,
                      Colors.pink.shade800,
                      Colors.pink.shade900,
                    ]
                )
              ),
              child: Text(LangText(context).getLang().splash_screen_start,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color:Colors.white,height: 1.5)),
            )
          ],
        ),
      ),
    );
  }
}
