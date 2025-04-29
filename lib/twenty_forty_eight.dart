import 'package:flutter/material.dart';

import 'grid_properties.dart';
import 'tile.dart';

class TwentyFortyEight extends StatefulWidget {
  const TwentyFortyEight({super.key});

  @override
  State<TwentyFortyEight> createState() => _TwentyFortyEightState();
}

class _TwentyFortyEightState extends State<TwentyFortyEight>
    with SingleTickerProviderStateMixin {
  // vars
  late AnimationController controller;
  List<List<Tile>> grid = List.generate(
    4,
    (y) => List.generate(4, (x) => Tile(x, y, 0)),
  );
  Iterable<Tile> get flattenedGrid => grid.expand((e) => e);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    grid[1][2].val = 4;
    grid[3][2].val = 16;
    for (var element in flattenedGrid) {
      element.resetAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    // vars
    double gridSize = MediaQuery.of(context).size.width - 16.0 * 2;
    double tileSize = (gridSize - 4 * 2) / 4;
    List<Widget> stackItems = [];
    // colors
    stackItems.addAll(
      flattenedGrid.map(
        (e) => Positioned(
          left: e.x * tileSize,
          top: e.y * tileSize,
          width: tileSize,
          height: tileSize,
          child: Center(
            child: Container(
              width: tileSize - 4 * 2,
              height: tileSize - 4 * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: lightBrown,
              ),
            ),
          ),
        ),
      ),
    );
    // tiles
    stackItems.addAll(
      flattenedGrid.map(
        (e) => AnimatedBuilder(
          animation: controller,
          builder:
              (context, child) =>
                  e.animatedValue.value == 0
                      ? SizedBox()
                      : Positioned(
                        left: e.x * tileSize,
                        top: e.y * tileSize,
                        width: tileSize,
                        height: tileSize,
                        child: Center(
                          child: Container(
                            width: tileSize - 4 * 2,
                            height: tileSize - 4 * 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: numTileColor[e.animatedValue.value],
                            ),
                            child: Center(
                              child: Text(
                                "${e.animatedValue.value}",
                                style: TextStyle(
                                  color:
                                      e.animatedValue.value <= 4
                                          ? greyText
                                          : Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
        ),
      ),
    );

    // main app
    return Scaffold(
      backgroundColor: tan,
      body: Center(
        child: Container(
          width: gridSize,
          height: gridSize,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: darkBrown,
          ),
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy < -250) {
                // swipe left
              } else if (details.velocity.pixelsPerSecond.dx > 250) {
                // swipe right
              }
            },
            onHorizontalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx < -1000 &&
                  canSwipeLeft()) {
                // swipe left
              } else if (details.velocity.pixelsPerSecond.dx > 1000) {
                // swipe right
              }
            },
            child: Stack(children: stackItems),
          ),
        ),
      ),
    );
  }

  bool canSwipeLeft() => grid.any(canSwipe);
  bool canSwipeRight() => grid.map((e) => e.reversed.toList()).any(canSwipe);
  bool canSwipe(List<Tile> tiles) {
    return false;
  }
}
