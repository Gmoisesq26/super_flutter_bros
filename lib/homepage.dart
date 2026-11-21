import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_flutter_bros/button.dart';
import 'package:super_flutter_bros/jumpingmario.dart';
import 'package:super_flutter_bros/mario.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1.025;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "rignt";
  bool midrun = false;
  bool midjump = false;

  void prejump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    midjump = true;
    prejump();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (initialHeight - height > 1.02) {
        midjump = false;
        setState(() {
          marioY = 1.025;
        });
        timer.cancel();
      } else {
        setState(() {
          marioY = initialHeight - height;
        });
      }
    });
  }

  void moveRight() {
    direction = "right";
    midrun = !midrun;

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";
    midrun = !midrun;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.blue,
              child: AnimatedContainer(
                alignment: Alignment(marioX, marioY),
                duration: Duration(milliseconds: 0),
                child: midjump
                    ? JumpingMario(direction: direction)
                    : MyMario(direction: direction, midrun: midrun),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    function: moveLeft,
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_upward, color: Colors.white),
                    function: jump,
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
          //5:22
        ],
      ),
    );
  }
}
