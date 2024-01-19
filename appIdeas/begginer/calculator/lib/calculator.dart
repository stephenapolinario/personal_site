import 'package:calculator/theme/custom_colors.dart';
import 'package:calculator/utils/scale_size.dart';
import 'package:flutter/material.dart';

enum ColorButton {
  normal,
  especial,
}

enum OperationType {
  number,
  clear,
  division,
  multiplication,
  subtraction,
  addition,
  equal,
  point,
  removeLast,
  percentage,
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstNum = 0;
  double secondNum = 0;
  String history = '';
  String textToDisplay = '';
  OperationType operationType = OperationType.number;
  OperationType lastOperation = OperationType.number;
  String result = '0';
  String lastResult = '0';

  void buttonPressed(
    String buttonText,
    OperationType operationType,
  ) {
    if (operationType != OperationType.number && textToDisplay == '') {
      return;
    }
    switch (operationType) {
      case OperationType.clear:
        textToDisplay = '';
        firstNum = 0;
        secondNum = 0;
        result = '';
        lastResult = '';
        lastOperation = OperationType.equal;
        break;
      case OperationType.number:
        result = double.parse(result + buttonText).toString();
      case OperationType.addition:
        firstNum = double.parse(textToDisplay);
        lastResult = result;
        result = '';
        lastOperation = OperationType.addition;
      case OperationType.multiplication:
        firstNum = double.parse(textToDisplay);
        lastResult = result;
        result = '';
        lastOperation = OperationType.multiplication;
      case OperationType.division:
        firstNum = double.parse(textToDisplay);
        lastResult = result;
        result = '';
        lastOperation = OperationType.division;
      case OperationType.subtraction:
        firstNum = double.parse(textToDisplay);
        lastResult = result;
        result = '';
        lastOperation = OperationType.subtraction;
      case OperationType.removeLast:
        result = textToDisplay.substring(0, textToDisplay.length - 1);
      case OperationType.equal:
        secondNum = double.parse(textToDisplay);
        switch (lastOperation) {
          case OperationType.addition:
            result = (firstNum + secondNum).toString();
            history = "$firstNum+$secondNum";
          case OperationType.division:
            result = (firstNum / secondNum).toString();
            history = "$firstNum/$secondNum";
          case OperationType.multiplication:
            result = (firstNum * secondNum).toString();
            history = "${firstNum}X$secondNum";
          case OperationType.subtraction:
            result = (firstNum - secondNum).toString();
            history = "$firstNum-$secondNum";
          default:
        }
      case OperationType.point:
        if (!result.contains('.')) {
          result += '.';
        }
      case OperationType.percentage:
        result = (double.parse(result) / 100).toString();
    }

    setState(() {
      if (result == '') {
        textToDisplay = lastResult;
      } else {
        textToDisplay = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.height;
    double widthContainer = currentWidth /
        (currentWidth >= 1400
            ? 5.6
            : currentWidth >= 800
                ? 4
                : 2);
    return Center(
      child: Container(
        width: widthContainer,
        height: currentHeight / (currentHeight < 900 ? 1.6 : 1.9),
        color: CustomColors.calculatorBackground(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            historyValue(),
            currentValue(),
            column1(),
            column2(),
            column3(),
            column4(),
            column5(),
          ],
        ),
      ),
    );
  }

  Widget currentValue() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        textToDisplay,
        style: const TextStyle(
          fontSize: 54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget historyValue() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        history,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CustomColors.historyValue(context),
        ),
      ),
    );
  }

  Column column5() {
    return Column(
      children: [
        Row(
          children: [
            buildButton(buttonText: '0', size: 2),
            buildButton(buttonText: ',', operationType: OperationType.point),
            buildButton(buttonText: '=', operationType: OperationType.equal),
          ],
        )
      ],
    );
  }

  Column column4() {
    return Column(
      children: [
        Row(
          children: [
            buildButton(buttonText: '1'),
            buildButton(buttonText: '2'),
            buildButton(buttonText: '3'),
            buildButton(buttonText: '+', operationType: OperationType.addition),
          ],
        )
      ],
    );
  }

  Column column3() {
    return Column(
      children: [
        Row(
          children: [
            buildButton(buttonText: '4'),
            buildButton(buttonText: '5'),
            buildButton(buttonText: '6'),
            buildButton(
                buttonText: '-', operationType: OperationType.subtraction),
          ],
        ),
      ],
    );
  }

  Column column2() {
    return Column(
      children: [
        Row(
          children: [
            buildButton(buttonText: '7'),
            buildButton(buttonText: '8'),
            buildButton(buttonText: '9'),
            buildButton(
                buttonText: 'X', operationType: OperationType.multiplication),
          ],
        )
      ],
    );
  }

  Column column1() {
    return Column(
      children: [
        Row(
          children: [
            buildButton(
              buttonText: 'C',
              operationType: OperationType.clear,
              color: ColorButton.especial,
            ),
            buildButton(
              buttonIcon: Icons.backspace,
              operationType: OperationType.removeLast,
              color: ColorButton.especial,
            ),
            buildButton(
              buttonText: '%',
              operationType: OperationType.percentage,
              color: ColorButton.especial,
            ),
            buildButton(buttonText: '/', operationType: OperationType.division),
          ],
        )
      ],
    );
  }

  Widget buildButton({
    String buttonText = '',
    IconData? buttonIcon,
    double size = 1,
    OperationType operationType = OperationType.number,
    ColorButton color = ColorButton.normal,
  }) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.height;
    return Expanded(
      flex: size.toInt(),
      child: SizedBox(
        height: currentHeight * 0.07,
        width: currentWidth * 0.005,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ElevatedButton(
            onPressed: () => buttonPressed(
              buttonText,
              operationType,
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: color == ColorButton.especial
                  ? CustomColors.especialButtonBackground(context)
                  : operationType == OperationType.number
                      ? CustomColors.normalButtonBackground(context)
                      : CustomColors.operationButtonBackground(context),
              shape: const RoundedRectangleBorder(),
            ),
            child: buttonIcon == null
                ? Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(
                      ScaleSize.textScaleFactor(
                        context,
                        maxTextScaleFactor: 1.6,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Icon(
                    buttonIcon,
                  ),
          ),
        ),
      ),
    );
  }
}
