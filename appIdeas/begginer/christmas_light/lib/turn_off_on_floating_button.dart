import 'package:flutter/material.dart';

class FloatingButtonOnOff extends StatelessWidget {
  const FloatingButtonOnOff({
    super.key,
    required this.interval,
    required this.animationOne,
    required this.animationTwo,
  });

  final AnimationController animationOne;
  final AnimationController animationTwo;
  final int interval;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (animationOne.isAnimating) {
          animationOne.forward().whenComplete(() {
            animationOne.stop();
          });
        } else {
          animationOne.forward();
        }
        if (animationTwo.isAnimating) {
          animationTwo.forward().whenComplete(() {
            animationTwo.stop();
          });
        } else {
          Future.delayed(
            Duration(milliseconds: interval),
            () => animationTwo.forward(),
          );
        }
      },
      tooltip: 'Turn On/Off string lights',
      child: const Icon(Icons.power_settings_new_outlined),
    );
  }
}
