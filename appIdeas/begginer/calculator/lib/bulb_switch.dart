import 'package:calculator/providers/theme_provider.dart';
import 'package:calculator/theme/custom_colors.dart';
import 'package:calculator/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BulbSwitch extends StatefulWidget {
  const BulbSwitch({super.key});

  @override
  State<BulbSwitch> createState() => _BulbSwitchState();
}

class _BulbSwitchState extends State<BulbSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Set your desired duration
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);

    return Positioned(
      left: MediaQuery.of(context).size.width / 40, //230.0,
      // bottom: MediaQuery.of(context).size.width / 0.68, //40.0,
      child: GestureDetector(
        onTap: () {
          themeChange.toggleTheme();

          if (animationController.status == AnimationStatus.forward ||
              animationController.status == AnimationStatus.completed) {
            animationController.reset();
            animationController.forward();
          } else {
            animationController.forward();
          }
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 7.5,
              width: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                shape: BoxShape.rectangle,
                color: CustomColors.bulbBackground(context),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 14),
                child: themeChange.themeData == lightTheme
                    ? Image.asset(
                        "assets/bulb_off.png",
                        fit: BoxFit.fitHeight,
                      )
                    : Image.asset(
                        "assets/bulb_on.png",
                        fit: BoxFit.fitHeight,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
