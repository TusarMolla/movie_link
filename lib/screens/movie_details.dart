import 'package:flutter/material.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/shimmer_helper.dart';
import 'package:movie_link/models/movie_details.dart';
import 'package:movie_link/my_theme.dart';
import 'package:movie_link/presenter/main_presenter.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  MainPresenter mainPresenter;
  MovieDetails({Key key,this.mainPresenter}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<MovieDetailsResponse>(
          stream: widget.mainPresenter.getMovieDetails,
          builder: (context, snapshot) {
            if(snapshot.hasData)
            // if(false)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()async{
                    print(snapshot.data.data.link);

                    if (await canLaunch(snapshot.data.data.link)){
                      await launch(snapshot.data.data.link);
                    }else{
                      print("false");
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.passthrough,
                    children: [
                      FadeInImage(
                        placeholder: AssetImage("assets/test.jpg"),
                        image: NetworkImage(snapshot.data.data.image),
                        height: 200,
                        width: DeviceInfo(context).width,
                        fit: BoxFit.cover,
                      ),
                      StreamBuilder<double>(
                        stream: widget.mainPresenter.getAnimationValue,
                        builder: (context, snapshot) {
                          return Center(
                              child: Container(
                                alignment: Alignment.center,
                                transformAlignment: Alignment.center,
                                height: 45,
                                width: 45,
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
                              ));
                        }
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                  child: Text(snapshot.data.data.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Row(
                    children: [
                      Text(snapshot.data.data.rating,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Icon(Icons.star_rate_rounded,color: MyTheme.ambr,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Text(snapshot.data.data.category,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Text("Duration: "+snapshot.data.data.duration+" hours",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Text("Releases: "+snapshot.data.data.releaseDate,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                  child: Text(snapshot.data.data.description,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                ),

              ],
            );
              else
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ShimmerHelper.basicShimmer(
                    height: 200.0,
                    width: DeviceInfo(context).width,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                    child:
                    ShimmerHelper.basicShimmer(
                      height: 20.0,
                      width: 290.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                    child:
                    ShimmerHelper.basicShimmer(
                      height: 20.0,
                      width: 200.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                    child:
                    ShimmerHelper.basicShimmer(
                      height: 20.0,
                      width: 250.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                    child:
                    ShimmerHelper.basicShimmer(
                      height: 20.0,
                      width: 280.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                    child:
                    ShimmerHelper.basicShimmer(
                      height: 20.0,
                      width: 210.0,
                    ),                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10),
                    child:
                    ShimmerHelper.basicShimmer(
                      height: 100.0,
                      width: DeviceInfo(context).width-40,
                    ),
                  ),

                ],
              );
            ;
          }
        ),
      ),
    );
  }
}
