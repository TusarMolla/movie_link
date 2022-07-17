import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/lang.dart';
import 'package:movie_link/dummy_data/dummy_data.dart';
import 'package:movie_link/ui_elements/category_item.dart';
import 'package:movie_link/ui_elements/grid_movie_item.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: (){
          return Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(slivers:[
          SliverToBoxAdapter(
            child: buildBodyContainer(context),
          )
        ],),
      ),
    );
  }

  Container buildBodyContainer(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildImageSliderContainer(context),
          buildCategoryContainer(),
          buildTopMovieContainer()
        ],
      ),
    );
  }

  Container buildTopMovieContainer() => Container(
    child: Container(
      margin: EdgeInsets.only(top: 16),
      width: DeviceInfo(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Top Movies",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
          ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            child: GridView.count(

              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: List.generate(DummyData.imageList.length, (index) => MovieGridItem(title:DummyData.imageList[index].title ,imageLink:DummyData.imageList[index].imageLink ,ratting:DummyData.imageList[index].ratting ,category:DummyData.imageList[index].category ,)),
            ),
          ),
        ],
      ),
    ),
  );

  Container buildCategoryContainer() => Container(
    height: 120,
    margin: EdgeInsets.only(top: 16),
    width: DeviceInfo(context).width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Category",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 80,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
              itemBuilder:(context,index){
            return CategoryItem(text: DummyData.categoryList[index].title,imageLink: DummyData.categoryList[index].image,);
          }, separatorBuilder: (context,index){
            return SizedBox(width: 10,);
          }, itemCount:  DummyData.categoryList.length),
        ),
      ],
    ),
  );

  Container buildImageSliderContainer(BuildContext context) {
    return Container(
          height: 200,
          child: CarouselSlider(
            items: List.generate(
              DummyData.imageList.length,
              (index) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    FadeInImage(
                      placeholder: AssetImage("assets/test.jpg"),
                      image: NetworkImage(
                          DummyData.imageList[index].imageLink),
                      fit: BoxFit.cover,
                      width: DeviceInfo(context).width/1.4,
                    ),
                    Positioned(
                      bottom: 1,
                      child: Container(
                        height: 120,
                        width: DeviceInfo(context).width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  //
                                  // Colors.white60.withOpacity(0.5),
                                  // Colors.white70.withOpacity(0.5),
                                  //Colors.white.withOpacity(0.5),
                                  Colors.grey.withOpacity(0.5),
                                  Colors.black12.withOpacity(0.5),
                                  Colors.black38.withOpacity(0.5),
                                  // Colors.black45.withOpacity(0.5),
                                  // Colors.black54.withOpacity(0.5),
                                  // Colors.black.withOpacity(0.5),
                                ])),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                DummyData.imageList[index].title ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(4),
                                      color: Colors.white70,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 2),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star_rate_rounded,
                                            color: Colors.amber,
                                            size: 12,
                                          ),
                                          Text(
                                            DummyData
                                                .imageList[index].ratting,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 8,
                                        bottom: 8,
                                        right: 8),
                                    child: Text(
                                      DummyData.imageList[index].duration,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 20,
                                      child: VerticalDivider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8, bottom: 8),
                                    child: Text(
                                      DummyData.imageList[index].category,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                aspectRatio: 2,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
          ),
        );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Text(LangText(context).getLang().home_page_title),
    );
  }
}
