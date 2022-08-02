// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BouncyPageRoute extends PageRouteBuilder{
  final Widget widget;

  BouncyPageRoute({this.widget})
      : super(
      transitionDuration: Duration(milliseconds: 700),
      transitionsBuilder: (BuildContext context,Animation<double> animation,Animation<double> scnd,
          Widget child){
        return ScaleTransition(
          child: child,
          alignment: Alignment.bottomLeft,
          scale: animation,
        );},
      pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> scnd){
        return widget;
      }
    );

}