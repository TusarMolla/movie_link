import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movie_link/custom/common_ui.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/shimmer_helper.dart';
import 'package:movie_link/models/movie_details.dart';
import 'package:movie_link/my_theme.dart';
import 'package:movie_link/others/ad_helper.dart';
import 'package:movie_link/presenter/main_presenter.dart';
import 'package:movie_link/screens/play_movie.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  MainPresenter mainPresenter;
  final id;

  MovieDetails({Key key, this.mainPresenter, this.id}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with SingleTickerProviderStateMixin {
  NativeAdListener listener;
  NativeAd myNative;

  bool appIsloaded = false;



  @override
  void initState() {
    listener = NativeAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        appIsloaded = true;
        setState(() {});
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
      // Called when a click is recorded for a NativeAd.
      onNativeAdClicked: (NativeAd ad) => print('Ad clicked.'),
    );

    myNative = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'adFactoryExample',
        request: AdRequest(),
        listener: listener,
        nativeAdOptions: NativeAdOptions(shouldRequestMultipleImages: true));

    widget.mainPresenter.setAnimation(this);
    widget.mainPresenter.checkIsFavorite(widget.id);
    myNative.load();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.mainPresenter.animationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<MovieDetailsResponse>(
            stream:
                widget.mainPresenter.fetchMovieDetails(widget.id).asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                // if(false)
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        fit: StackFit.passthrough,
                        children: [
                          SizedBox(
                            height: 250,
                          ),
                          Container(
                            height: 250,
                            width: DeviceInfo(context).width,
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: FadeInImage(
                                placeholder:
                                    AssetImage("assets/place_holder.jpg"),
                                image: NetworkImage(snapshot.data.data.image),
                                height: 300,
                                width: DeviceInfo(context).width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          FadeInImage(
                            placeholder:
                                AssetImage("assets/place_holder.jpg"),
                            image: NetworkImage(snapshot.data.data.image),
                            height: 200,
                            width: DeviceInfo(context).width * 0.8,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            right: 50,
                            bottom: 10,
                            child: StreamBuilder<double>(
                                initialData: 35,
                                stream:
                                    widget.mainPresenter.getAnimationValue,
                                builder: (context, animationSnapshot) {
                                  return
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            splashFactory:InkRipple.splashFactory
                                        ),
                                        onPressed: ()async {
                                          if (await canLaunch(snapshot.data.data.link)) {
                                            await launch(snapshot.data.data.link);
                                          }
                                         // slideRightWidget(newPage: MoviePlay(url: snapshot.data.data.link,), context: context);
                                        },
                                      child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(height: 60, width: 60),
                                      Container(
                                        alignment: Alignment.center,
                                        transformAlignment: Alignment.center,
                                        height: animationSnapshot.data,
                                        width: animationSnapshot.data,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.2),
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
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        transformAlignment: Alignment.center,
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: MyTheme.ambr,
                                        ),
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: 35,
                                          color: MyTheme.white,
                                        ),
                                      ),
                                    ],
                                  ));
                                }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 30),
                        child: Text(
                          snapshot.data.data.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                        padding: EdgeInsets.all(16),
                        decoration: CommonUi.decorations(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot.data.data.rating,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: MyTheme.ambr,
                                ),
                                StreamBuilder<bool>(
                                    stream: widget.mainPresenter.getIsFavorite,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData)
                                        return IconButton(
                                            splashRadius: 2,
                                            onPressed: () {
                                              if (snapshot.data)
                                                widget.mainPresenter
                                                    .deleteFavorite(widget.id);
                                              else
                                                widget.mainPresenter
                                                    .addFavorite(widget.id);
                                            },
                                            icon: Icon(
                                              snapshot.data
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red.shade800,
                                            ));
                                      else
                                        return Icon(Icons.favorite_border);
                                      ;
                                    }),
                                Spacer(),
                                /*TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey),
                                    onPressed: ()async {

                                    },
                                    child: Text(
                                      "Open in browser",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: MyTheme.accent_black),
                                    ))*/
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "category",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 16),
                                ),
                                Text(
                                  snapshot.data.data.category,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                                Text(
                                  snapshot.data.data.duration,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Releases",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                                Text(
                                  snapshot.data.data.releaseDate,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (appIsloaded)
                        Container(
                          width: DeviceInfo(context).width,
                          height: 200,
                          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                          padding: EdgeInsets.all(16),
                          decoration: CommonUi.decorations(),
                          child: AdWidget(ad: myNative),
                        ),
                      Container(
                        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                        padding: EdgeInsets.all(16),
                        decoration: CommonUi.decorations(),
                        child: Text(
                          snapshot.data.data.description,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              else
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerHelper.basicShimmer(
                      height: 200.0,
                      width: DeviceInfo(context).width,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                      child: ShimmerHelper.basicShimmer(
                        height: 20.0,
                        width: 290.0,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                      child: ShimmerHelper.basicShimmer(
                        height: 20.0,
                        width: 200.0,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                      child: ShimmerHelper.basicShimmer(
                        height: 20.0,
                        width: 250.0,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                      child: ShimmerHelper.basicShimmer(
                        height: 20.0,
                        width: 280.0,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                      child: ShimmerHelper.basicShimmer(
                        height: 20.0,
                        width: 210.0,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                      child: ShimmerHelper.basicShimmer(
                        height: 100.0,
                        width: DeviceInfo(context).width - 40,
                      ),
                    ),
                  ],
                );
              ;
            }),
      ),
    );
  }
}
