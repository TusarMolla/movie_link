import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_link/custom/common_ui.dart';
import 'package:movie_link/custom/device_info.dart';
import 'package:movie_link/custom/lang.dart';
import 'package:movie_link/custom/shimmer_helper.dart';
import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/sliders.dart';
import 'package:movie_link/my_theme.dart';
import 'package:movie_link/presenter/main_presenter.dart';

import 'package:movie_link/ui_elements/category_item.dart';
import 'package:movie_link/ui_elements/grid_movie_item.dart';

class Home extends StatelessWidget {
  Home({Key key, this.presenter}) : super(key: key);

  MainPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.accent_color,
      //appBar: buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () {
          presenter.homeReset();
          return Future.delayed(Duration(seconds: 1));
        },
        child: CustomScrollView(
          controller: presenter.mainScrollController,
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: buildBodyContainer(context),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBodyContainer(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        buildImageSliderContainer(context),
        buildCategoryContainer(),
        buildTopMovieContainer()
      ],
    );
  }

  Widget buildTopMovieContainer() => StreamBuilder<List<MovieData>>(
      stream: presenter.allMovie,
      builder: (context, snapshot) {
        print(snapshot.hasData);
        return Container(

          margin: EdgeInsets.only(top: 16),
          width: DeviceInfo(context).width,
          child: snapshot.hasData?
          Container(
            alignment: Alignment.center,
            child: GridView.count(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 60),
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: List.generate(
                  snapshot.data.length,
                  (index) => MovieGridItem(
                        title: snapshot.data[index].name,
                        imageLink: snapshot.data[index].image,
                        ratting: snapshot.data[index].rating,
                        category: snapshot.data[index].category,
                        presenter: presenter,
                        id:snapshot.data[index].id.toString() ,
                        index: index,
                      )),
            ),
          )
          :
            buildTopMovieShimmer(context),
        );
      });

  Widget buildTopMovieShimmer(context) => Container(
        alignment: Alignment.center,
        child: GridView.count(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 60),
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children: List.generate(
              10,
              (index) => ShimmerHelper.basicShimmer(
                    height: 200.0,
                    width: DeviceInfo(context).width / 2,
                radius: 10.0
                  )),
        ),
      );

  Widget buildCategoryContainer() => StreamBuilder<CategoriesResponse>(
      stream: presenter.allCategory,
      builder: (context, snapshot) {
        return Container(

          height: 80,
          margin: EdgeInsets.only(top: 16),
          width: DeviceInfo(context).width,
          child: SizedBox(
            height: 80,
            child: snapshot.hasData
                // false
                ? buildCategoryList(snapshot)
                : buildCategoryShimmerList(),
          ),
        );
      });

  ListView buildCategoryList(AsyncSnapshot<CategoriesResponse> snapshot) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryItem(
            text: snapshot.data.data[index].name,
            imageLink: snapshot.data.data[index].image,
            presenter: presenter,
            id: snapshot.data.data[index].id.toString(),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
        itemCount: snapshot.data.data.length);
  }

  ListView buildCategoryShimmerList() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(bottom: 8),
            // decoration: CommonUi.shdowDecoration(spreadRadius: 10),
            height: 100,
            width: 80,
            child: ShimmerHelper.basicShimmer(
                height: 80.0, width: 80.0, radius: 10.0),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
        itemCount: 10);
  }

  Widget buildImageSliderContainer(BuildContext context) {
    return StreamBuilder<SlidersResponse>(
        stream: presenter.allSlide,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return imageSliderShimmer(context);
          } else {
            return CarouselSlider(
              items: List.generate(
                snapshot.data.data.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: DeviceInfo(context).width,
                    padding: EdgeInsets.only(bottom: 10),
                    //color: Colors.grey,
                    decoration: CommonUi.shdowDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          FadeInImage(
                            placeholder: AssetImage("assets/test.jpg"),
                            image: NetworkImage(snapshot.data.data[index].url),
                            fit: BoxFit.cover,
                            width: DeviceInfo(context).width / 1.4,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 80,
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
                                        MyTheme.accent_black.withOpacity(0.0),
                                        MyTheme.accent_black,
                                        // Colors.black45.withOpacity(0.5),
                                        // Colors.black54.withOpacity(0.5),
                                        // Colors.black.withOpacity(0.5),
                                      ])),
                              /*child: Padding(
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
                              ),*/
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                aspectRatio: 2.5,
                enlargeCenterPage: true,
                viewportFraction: 1,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
            );
          }
        });
  }

  Widget imageSliderShimmer(context) {
    return CarouselSlider(
      items: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShimmerHelper.slideShimmer(context),
        ),
      ),
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: true,
        aspectRatio: 2.5,
        enlargeCenterPage: true,
        viewportFraction: 1,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
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

