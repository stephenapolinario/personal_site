import 'package:flutter/material.dart';

enum Position {
  first,
  middle,
  last,
}

class Bulb extends StatelessWidget {
  const Bulb({
    super.key,
    required this.colorOff,
    required this.colorOn,
    required this.colorShadow,
    required this.animation,
    this.position = Position.middle,
  });

  final Position position;
  final Color colorShadow;
  final Color colorOn;
  final Color colorOff;
  final AnimationController animation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; //1912
    double screenHeight = MediaQuery.of(context).size.height; //958
    return SizedBox(
      height: screenHeight / 6.38,
      width: screenWidth / 12.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            child: Container(
              width: screenWidth * 0.014,
              height: 55,
              decoration: const BoxDecoration(
                color: Colors.black54,
              ),
            ),
          ),
          Positioned(
            top: 40,
            child: Container(
              width: screenWidth * 0.017,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.orange.shade800,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInExpo,
            ),
            builder: (context, child) {
              return Container(
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorTween(
                            begin: colorShadow,
                            end: Colors.transparent,
                          ).evaluate(
                            animation,
                          ) ??
                          Colors.transparent,
                      blurRadius: 25,
                      spreadRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                  color: ColorTween(
                    begin: colorOn,
                    end: colorOff,
                  ).evaluate(
                    animation,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
