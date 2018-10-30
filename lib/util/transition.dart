import 'package:flutter/material.dart';

PageRouteBuilder pageRouteBuilderTo(StatefulWidget page) {
  return new PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 250),
      pageBuilder: (BuildContext context, _, __) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return rightSlideTransition(child, animation);
      });
}

SlideTransition rightSlideTransition(Widget child, Animation animation) {
  return new SlideTransition(
    child: child,
    position: new Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(animation),
  );
}
