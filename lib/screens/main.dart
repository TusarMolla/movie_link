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

class _MainPageState extends State<MainPage>{
  MainPresenter mainPresenter;

  @override
  void initState() {
    mainPresenter= MainPresenter();
    // TODO: implement initState
   //mainPresenter= Provider.of<MainPresenter>(context, listen: false);
    super.initState();
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
          body: buildBody(snapshot.data),
          bottomNavigationBar: buildBottomNavigationBar(snapshot),
        );
      }
    );
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
}
