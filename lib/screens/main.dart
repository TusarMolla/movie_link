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
  MainPresenter mainPresenter= MainPresenter();

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
      body: StreamBuilder<int>(
        stream: mainPresenter.getIndex,
        builder: (context, snapshot) {
          return Container(
            child: buildBody(snapshot.data),
          );
        }
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
     return StreamBuilder<int>(
       initialData: 0,
       stream: mainPresenter.getIndex,
       builder: (context, snapshot) {
         return BottomNavigationBar(
          onTap: (index) {
            mainPresenter.add(index);
          },
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
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.live_tv_rounded), label: "TV"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite"),
          ],
    );
       }
     );
  }

  Widget buildBody(intdex) {
      switch (intdex) {
        case 0:
          return Home();
          break;
        case 1:
          return Tranding();
          break;
        case 2:
          return TV();
          break;
        case 3:
          return Favorite();
          break;
        default:
          return Home();
      }

  }
}
