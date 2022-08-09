import 'package:flutter/material.dart';
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

class _MainPageState extends State<MainPage> {
  MainPresenter mainPresenter= MainPresenter(0);

  @override
  void initState() {
    // TODO: implement initState
   //mainPresenter= Provider.of<MainPresenter>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        child: buildBody(),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
     return BottomNavigationBar(
      onTap: (index) {
        mainPresenter.changeCurrentIndex(index);
      },
      currentIndex: mainPresenter.state,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.whatshot_outlined),
          label: "Tranding",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_rounded), label: "TV"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: "Favorite"),
      ],
    );
  }

  Widget buildBody() {
      switch (mainPresenter.state) {
        case 0:
          return Home();
          break;
        case 1:
          //return Tranding();
          break;
        case 2:
         // return TV();
          break;
        case 3:
          //return Favorite();
          break;
        default:
          return Home();
      }

  }
}
