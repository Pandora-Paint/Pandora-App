import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pandora',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pandora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _rawPoints = <Offset>[];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) => {
          setState(() {
            _rawPoints.clear();
            _rawPoints.add(details.globalPosition);
          })
        },
        onPanUpdate: (details) => {
          setState(() {
            _rawPoints.add(details.globalPosition);
          })
        },
        onPanEnd: (details) => {
          setState(() {
            
          })
         },

        child: CustomPaint(
          painter: ShapePainter(_rawPoints),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {

  final _points;

  ShapePainter(this._points): super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.orange
    ..isAntiAlias = true
    ..strokeWidth = 3;
    canvas.drawPoints(PointMode.polygon, _points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
