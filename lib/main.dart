
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';


void main() async{


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class Post{
  final int access_token;
  final int refresh_token;
  Post({required this.access_token,required this.refresh_token});
  factory Post.fromJson(Map<String,dynamic>json){
    return Post(
      access_token: json['access_token'],
      refresh_token: json['refresh_token']
    );
  }
}
class _MyHomePageState extends State<MyHomePage> {
late InAppWebViewController controller;

Future<Post> fetchPost() async{
  final response=await http.get(Uri.https('http://192.168.0.121:8080/start','/posts/1'));
  if (response.statusCode==200){
    return Post.fromJson(json.decode(response.body));

  }
  else{
    throw Exception('Failed to load post');
  }

}


  // Future<bool> ?_onBackPressed() {
  //
  //   var future = _webViewController.canGoBack();
  //   future.then((canGoBack) {
  //     if (canGoBack) {
  //       _webViewController.goBack();
  //     }
  //     else {
  //
  //   return showDialog(
  //       context: context,
  //       builder: (context) =>
  //           AlertDialog(
  //             title: Text("Do you want to exit the app?"),
  //             actions: <Widget>[
  //               FloatingActionButton(
  //                 child: Text("NO"),
  //                 onPressed: () => Navigator.pop(context, false),
  //
  //               ),
  //               FloatingActionButton(
  //                 child: Text("yes"),
  //                 onPressed: () =>  Navigator.pop(context, true),
  //
  //
  //               )
  //             ],
  //           )
  //   );
  //
  //
  // }
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // child: Web(

        body: SafeArea(
            child: InAppWebView(
                initialUrlRequest:
                URLRequest(url: Uri.parse("http://192.168.0.121:8080/start")),
               
               // initialHeaders: {},
                onWebViewCreated: (InAppWebViewController w) {
                  controller=w;

                  controller.addJavaScriptHandler(
                      handlerName: "Print", callback: (args) {
                    print("from java:");
                    print(args);
                    //return args;
                  });


                  },
                onConsoleMessage:
                    (controller, consoleMessage) {
                  log("zzConsole:$consoleMessage");
                  print(consoleMessage);
                }

            )
        )
    );
  }


}









      //   ),
      // );
      // onWillPop: () {
      //
      //   var future = _webViewController.canGoBack();
      //   future.then((canGoBack) {
      //     if (canGoBack) {
      //       _webViewController.goBack();
      //
      //     }
      //     else {
      //       print("종료");
      //
      //     }
      //   }
      //
      //   );
      //   return Future.value(false);
      // },);
//   }
