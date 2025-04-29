import 'package:flutter/material.dart';

class Tile {
  final int x;
  final int y;
  int val;
  late Animation<double> animatedX;
  late Animation<double> animatedY;
  late Animation<int> animatedValue;
  late Animation<double> scale;
  Tile(this.x, this.y, this.val) {
    resetAnimation();
  }
  void resetAnimation() {
    animatedX = AlwaysStoppedAnimation(x.toDouble());
    animatedY = AlwaysStoppedAnimation(y.toDouble());
    animatedValue = AlwaysStoppedAnimation(val);
    scale = AlwaysStoppedAnimation(1);
  }
}
