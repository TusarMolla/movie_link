import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MoviePlay extends StatefulWidget {
   MoviePlay({Key key, this.url}) : super(key: key);
  final String url;

  @override
  State<MoviePlay> createState() => _MoviePlayState();
}

class _MoviePlayState extends State<MoviePlay> {

    WebViewController _controller;

   @override
  void initState() {
   _controller  =WebViewController()
     ..setJavaScriptMode(JavaScriptMode.disabled)
     ..setBackgroundColor(const Color(0x00000000))
     ..canGoBack()
     ..canGoForward()
     ..loadRequest(Uri.parse(widget.url))
   ;
   print(widget.url);
     // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    WillPopScope(
      onWillPop: ()async{
        if(await _controller.canGoBack()){
          _controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: WebViewWidget(controller: _controller,
      )


      ),
    );
  }
}
