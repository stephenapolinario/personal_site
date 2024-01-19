import 'package:christmas_light/interval_slider.dart';
import 'package:christmas_light/bulb.dart';
import 'package:christmas_light/colors.dart';
import 'package:christmas_light/turn_off_on_floating_button.dart';
import 'package:christmas_light/wire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Christmas Lights',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationOne;
  late AnimationController _animationTwo;
  int _interval = 750;

  @override
  void initState() {
    _animationOne = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _interval),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationOne.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationOne.forward();
        }
      });
    _animationTwo = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _interval),
      value: 1,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationTwo.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationTwo.forward();
        }
      });
    _animationOne.forward();
    _animationTwo.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; //1912
    return Scaffold(
      backgroundColor: const Color.fromRGBO(38, 38, 38, 1),
      floatingActionButton: FloatingButtonOnOff(
        animationOne: _animationOne,
        animationTwo: _animationTwo,
        interval: _interval,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        left: screenWidth * 0.053,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 1,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 2,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 3,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 4,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 5,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 6,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 7,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Positioned(
                        left: screenWidth * 0.053 + (screenWidth * 0.099) * 8,
                        top: 0,
                        child: const SemiOval(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Bulb(
                            position: Position.first,
                            colorOff: colorRedOff,
                            colorOn: colorRedOn,
                            colorShadow: colorRedShadow,
                            animation: _animationOne,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorBlueOff,
                            colorOn: colorBlueOn,
                            colorShadow: colorBlueShadow,
                            animation: _animationTwo,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorGreenOff,
                            colorOn: colorGreenOn,
                            colorShadow: colorGreenShadow,
                            animation: _animationOne,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorOrangeOff,
                            colorOn: colorOrangeOn,
                            colorShadow: colorOrangeShadow,
                            animation: _animationTwo,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorPurpleOff,
                            colorOn: colorPurpleOn,
                            colorShadow: colorPurpleShadow,
                            animation: _animationOne,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorRedOff,
                            colorOn: colorRedOn,
                            colorShadow: colorRedShadow,
                            animation: _animationTwo,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorBlueOff,
                            colorOn: colorBlueOn,
                            colorShadow: colorBlueShadow,
                            animation: _animationOne,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorGreenOff,
                            colorOn: colorGreenOn,
                            colorShadow: colorGreenShadow,
                            animation: _animationTwo,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorOrangeOff,
                            colorOn: colorOrangeOn,
                            colorShadow: colorOrangeShadow,
                            animation: _animationOne,
                          ),
                          Bulb(
                            position: Position.first,
                            colorOff: colorPurpleOff,
                            colorOn: colorPurpleOn,
                            colorShadow: colorPurpleShadow,
                            animation: _animationTwo,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IntervalSlider(
              interval: _interval,
              onChanged: (value) {
                setState(() {
                  _interval = value.toInt();
                  _animationOne.duration = Duration(milliseconds: _interval);
                  _animationTwo.duration = Duration(milliseconds: _interval);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
