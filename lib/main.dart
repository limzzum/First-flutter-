
import 'dart:async' show Future;
import 'dart:convert';
import 'dart:developer';

//import 'dart:html';
// import 'package:html/dom.dart' ;
// import 'package:html/dom_parsing.dart';
// import 'package:html/parser.dart';
//import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//jenkins 자동 빌드 테스트
//자동 빌드
//자동 빌드 제발
class Token {
  final dynamic access;
  final dynamic refresh;


  Token({ required this.access, required this.refresh});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        access: json['access_token'],
        refresh: json['refresh_token']

    );
  }
}

Future<http.Response> fetchPost() {
  return http.get(Uri.parse("http://192.168.0.121:8080/start"));
}
Future getData() async {
  http.Response response = await http.get(Uri.parse("http://192.168.0.121:8080/start"));

  if (response.statusCode == 200) {
    String data = response.body;
    return jsonDecode(data);
  } else {
    print(response.statusCode);
  }
}

 Future<Token> fetchToken() async{
  final response =  await http.get(Uri.parse("http://192.168.0.121:8080/start"));
   //return Token.fromJson(json.decode(response.body));
//print(response);

  if (response.statusCode == 200) {
    // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
    return Token.fromJson(json.decode(response.body));

  } else {
    // 만약 응답이 OK가 아니면, 에러를 던집니다.
    print("server error");
    throw Exception('Failed to load post../');
  }
}
//Future
loadToken() async {
   Token token =  (await fetchToken()) ;

  //  final jsonResponse = json.decode(string);
  //  Token token = new Token.fromJson(jsonResponse);
  // //
  print(token.access);

}

 receiveMessage(event) {
  if (event.origin != "http://192.168.0.121:8080")
    return;
print(event.source);
//loadToken(event.data);
}
void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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


class _MyHomePageState extends State<MyHomePage> {
  late InAppWebViewController controller;

   get window => null;

//late Future<Token> post;
// @override
// void initState(){
//   super.initState();
//   post=fetchPost();
// }


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
                URLRequest(url: Uri.parse( "http://192.168.0.121:8080/start")),
                onLoadStart: (controller, url) async {
                  loadToken();
                  print("onloadstart $url");

                },
                onLoadStop: (controller, url) async {
                  print('$url');
                },
                //initialHeaders: {},
                onWebViewCreated: (InAppWebViewController w) {
                  controller=w;
                  
                  controller.addJavaScriptHandler(
                      handlerName: "Print", callback: (args) {
                    print("from java:");
                    print(args);

                    //return args;
                  });
                  // message event listener


                  //window.addEventListener("message", receiveMessage, false);
                  //   window.onMessage.listen((event) {
                  //     print(event.data+"11111111111111111");
                  //   // do something with received data
                  //   });

  },
    onConsoleMessage:
                (controller, consoleMessage) {
        log("zzConsole:$consoleMessage");
      // var u= controller.getUrl();
                 // loadToken(consoleMessage.message);
// print(consoleMessage.message);
// print(jsonDecode(consoleMessage.message));
        }

    )
    )
    );
  }




                // onConsoleMessage:
                //     (controller, consoleMessage) {
                //   log("zzConsole:$consoleMessage");
                //   print(consoleMessage);
                // }

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
