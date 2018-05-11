import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'bar.dart';

void main() {
  runApp(new MaterialApp(home: new ChartPage()));
}

class ChartPage extends StatefulWidget {
  @override
  ChartPageState createState() => new ChartPageState();
}

class ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  final random = new Random();
  AnimationController animation;
  
  Animation<double> ani;
  int dataSet = 0;

  BarTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    ani = new CurvedAnimation(parent: animation, curve: Curves.easeIn);

    tween = new BarTween(new Bar.empty(), new Bar.random(random));
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {

      
      tween = new BarTween(new Bar.empty(), new Bar.random(random));
      //tween = new BarTween(tween.evaluate(animation), new Bar.random(random));


      dataSet++;
      animation.forward(from: 0.0);
      ani.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } 

      /*else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }*/
    });



      //CAMBIO #002 Rollbacked
      //this(repaint: animation);
      //tween = new BarTween(tween.evaluate(animation),new Bar.empty());
      //animation.forward(from: 0.0);

      //CAMBIO #001 Rollbacked
      //animation.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        
        child: new CustomPaint(
          size: new Size(400.0, 100.0),
          painter: new BarChartPainter(tween.animate(animation)),
        child: new Text('$dataSet'),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }
}