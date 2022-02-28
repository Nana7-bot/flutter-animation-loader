import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;

  double initialCenterRadius = 70.0;

  double centerRadius = 0;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animationRotation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller, curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    animationRadiusIn = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animationRadiusOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          centerRadius = animationRadiusIn.value * initialCenterRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          centerRadius = animationRadiusOut.value * initialCenterRadius;
        }
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
          child: RotationTransition(
        turns: animationRotation,
        child: Stack(
          children: [
            Dot(dotRadius: 70.0, dotColor: Colors.red),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 1,
              colorDot: Colors.blue,
            ),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 2,
              colorDot: Colors.black,
            ),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 3,
              colorDot: Colors.black,
            ),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 4,
              colorDot: Colors.grey,
            ),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 5,
              colorDot: Colors.green,
            ),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 6,
              colorDot: Colors.pink,
            ),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 7,
              colorDot: Colors.brown,
            ),
            SmallSmallDot(
              centerRadius: centerRadius,
              dotNumber: 8,
              colorDot: Colors.greenAccent,
            ),
          ],
        ),
      )),
    );
  }
}

class SmallSmallDot extends StatelessWidget {
  const SmallSmallDot(
      {Key? key,
      required this.centerRadius,
      required this.dotNumber,
      required this.colorDot})
      : super(key: key);

  final double centerRadius;
  final double dotNumber;
  final Color colorDot;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        centerRadius * cos(dotNumber * pi / 4),
        centerRadius * sin(dotNumber * pi / 4),
      ),
      child: Dot(dotRadius: 5.0, dotColor: colorDot),
    );
  }
}

class Dot extends StatelessWidget {
  Dot({required this.dotRadius, required this.dotColor});
  final double dotRadius;
  final Color dotColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: dotRadius,
        height: dotRadius,
        decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
      ),
    );
  }
}
