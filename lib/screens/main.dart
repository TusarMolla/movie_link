import 'package:flutter/material.dart';



class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex=0;
  changeCurrentIndex(index){
setState(() {
  _currentIndex=index;
});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(


      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index){
changeCurrentIndex(index);
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot_outlined),label: "Tranding",backgroundColor: Colors.yellow),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv_rounded),label: "TV"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorite"),
        ],
      ),
    );
  }
}
