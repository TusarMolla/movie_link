import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:movie_link/custom/lang.dart';
import 'package:movie_link/others/ad_helper.dart';
import 'package:movie_link/presenter/main_presenter.dart';
import 'package:movie_link/screens/favorite.dart';
import 'package:movie_link/screens/home.dart';
import 'package:movie_link/screens/tranding.dart';
import 'package:movie_link/screens/tv.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  MainPresenter mainPresenter;
  BannerAd _anchoredAdaptiveAd;
  bool _isLoaded = false;
   bool isBannerLoad= false;

  final InAppReview inAppReview = InAppReview.instance;


   BannerAdListener listener;

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId: AdHelper.bannerAdUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd.load();
  }

  @override
  void initState() {

    //inAppReview.openStoreListing(appStoreId: '...', microsoftStoreId: '...',);
    Future.delayed(Duration(seconds: 2)).then((value)async{

      if( await inAppReview.isAvailable()){


    inAppReview.requestReview();
      }else{

      }

    });




    mainPresenter= MainPresenter();
    // TODO: implement initState
   //mainPresenter= Provider.of<MainPresenter>(context, listen: false);
    super.initState();


  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    mainPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: mainPresenter.getIndex,
      builder: (context, snapshot) {
        return Scaffold(
          extendBody: true,
          appBar:buildAppBar(context, snapshot.data) ,
          body: buildBody(snapshot.data),
          bottomNavigationBar: buildBottomNavigationBar(snapshot),
        );
      }
    );
  }
  AppBar buildAppBar(BuildContext context,index) {

    return AppBar(
      elevation: 2,
      title:
      Text(title(index)),
      actions: [
        TextButton(onPressed: (){
          inAppReview.openStoreListing();
        }, child: Text("Ratings & Reviews",style: TextStyle(fontSize: 14,color: Colors.white),))
      ],
      bottom: PreferredSize(
        child: _anchoredAdaptiveAd != null && _isLoaded?
      Container(
      color: Colors.green,
      width: _anchoredAdaptiveAd.size.width.toDouble(),
      height: _anchoredAdaptiveAd.size.height.toDouble(),
      child: AdWidget(ad: _anchoredAdaptiveAd),
    ):Container(),
        preferredSize:_anchoredAdaptiveAd==null?Size(0, 0): Size(_anchoredAdaptiveAd.size.width.toDouble()??0, _anchoredAdaptiveAd.size.height.toDouble()??0),),
    );
  }

  String title(index){
     switch(index){
      case 0:
        return  LangText(context).getLang().home_page_title;
       case 1:
        return  LangText(context).getLang().tranding_page_title;
       case 2:
        return  LangText(context).getLang().tv_page_title;
       case 3:
        return  LangText(context).getLang().favorite_page_title;
    }
  }

  Widget buildBottomNavigationBar(snapshot) {
     return  BottomNavigationBar(
       onTap: (index) {
         mainPresenter.add(index);
       },
       backgroundColor: Colors.black.withOpacity(0.5),
       currentIndex: snapshot.data,
       items: [
         BottomNavigationBarItem(
           icon: Icon(Icons.home),
           label: "Home",
           backgroundColor: Colors.black.withOpacity(0.5),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.whatshot_outlined),
           label: "Tranding",
           backgroundColor: Colors.black.withOpacity(0.5),
         ),
         BottomNavigationBarItem(
             icon: Icon(Icons.live_tv_rounded), label: "TV",
           backgroundColor: Colors.black.withOpacity(0.5),
         ),
         BottomNavigationBarItem(
             icon: Icon(Icons.favorite), label: "Favorite",
           backgroundColor: Colors.black.withOpacity(0.5),
         ),
       ],
     );
  }

  Widget buildBody(intdex) {

      switch (intdex) {
        case 0:
          return Home(presenter:mainPresenter);
        // return Text("kk");
          break;
        case 1:
          return Tranding(presenter: mainPresenter,);
          break;
        case 2:
          return TV(presenter: mainPresenter,);
          break;
        case 3:
          return Favorite(presenter: mainPresenter,);
          break;
        default:
          return Home(presenter: mainPresenter);
      }
  }


  /*Widget bannerAdd(){
    return  Container(

      alignment: Alignment.center,
      child: AdWidget(ad: myBanner,),
      width: 300,
      height: 50,
    );

  }*/
}
