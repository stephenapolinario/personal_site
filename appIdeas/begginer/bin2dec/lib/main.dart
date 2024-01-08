import 'package:bin2dec/providers/dark_theme_provider.dart';
import 'package:bin2dec/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
//Import the font package
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

enum ConverterType {
  binToDec,
  decToBin,
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeChangeProvider,
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Bin2Dec',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: BinToDec(themeChangeProvider: themeChangeProvider),
          );
        },
      ),
    );
  }
}

class BinToDec extends StatefulWidget {
  final DarkThemeProvider themeChangeProvider;

  const BinToDec({
    super.key,
    required this.themeChangeProvider,
  });

  @override
  State<BinToDec> createState() => _BinToDecState();
}

class _BinToDecState extends State<BinToDec> {
  late AnimationController animationController;

  late Animation<double> animation;
  bool cirAn = false;

  final _decController = TextEditingController();
  final _binController = TextEditingController();
  final _focusDec = FocusNode();
  final _focusBin = FocusNode();
  // Starting decimal to binary
  // bool isDecimalFirst = true;
  var converter = ConverterType.decToBin;

  bool isDecimalHovered = false;
  bool isBinaryHovered = false;

  bool isDecFocused = false;
  bool isBinFocused = false;

  @override
  void initState() {
    _decController.addListener(_binConverter);
    _binController.addListener(_binConverter);

    _focusDec.addListener(() {
      setState(() {
        isDecFocused = _focusDec.hasFocus;
      });
    });

    _focusBin.addListener(() {
      setState(() {
        isBinFocused = _focusBin.hasFocus;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _decController.dispose();
    _binController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          bulbTheme(context, themeChange),
          title(context),
          forms(),
        ],
      ),
    );
  }

  Center forms() {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: converter == ConverterType.decToBin
                ? Wrap(
                    key: Key(ConverterType.decToBin.toString()),
                    direction: Axis.vertical,
                    spacing: 20,
                    children: [decimalNumber(), binaryNumber()],
                  )
                : Wrap(
                    key: Key(ConverterType.binToDec.toString()),
                    direction: Axis.vertical,
                    spacing: 20,
                    children: [binaryNumber(), decimalNumber()],
                  ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                converter == ConverterType.binToDec
                    ? converter = ConverterType.decToBin
                    : converter = ConverterType.binToDec;
              });
            },
            icon: const Icon(
              Icons.swap_vert_outlined,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  Positioned bulbTheme(BuildContext context, DarkThemeProvider themeChange) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 10, //230.0,
//              bottom: MediaQuery.of(context).size.width / 0.68, //40.0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            cirAn = true;
          });
          themeChange.darkTheme = !themeChange.darkTheme;

          if (animationController.status == AnimationStatus.forward ||
              animationController.status == AnimationStatus.completed) {
            animationController.reset();
            animationController.forward();
          } else {
            animationController.forward();
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 7.5,
          width: MediaQuery.of(context).size.height / 15,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            shape: BoxShape.rectangle,
            color: widget.themeChangeProvider.darkTheme
                ? Colors.white60
                : Colors.black54,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 14),
            child: widget.themeChangeProvider.darkTheme
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
      ),
    );
  }

  decimalNumber() {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isDecimalHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isDecimalHovered = false;
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width < 900
            ? MediaQuery.of(context).size.width / 1.5
            : 400,
        child: MouseRegion(
          onEnter: (event) => setState(() {
            isDecimalHovered = true;
          }),
          onExit: (event) => setState(() {
            isDecimalHovered = false;
          }),
          child: TextField(
            focusNode: _focusDec,
            readOnly: converter == ConverterType.binToDec,
            style: TextStyle(
              color: widget.themeChangeProvider.darkTheme
                  ? Colors.white
                  : Colors.black,
            ),
            controller: _decController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp("[0-9]"),
              ),
            ],
            decoration: InputDecoration(
              icon: _binController.text.isNotEmpty &&
                      converter == ConverterType.binToDec
                  ? copyButton(_decController)
                  : null,
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: converter == ConverterType.binToDec
                      ? Colors.green
                      : Colors.deepPurple,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: converter == ConverterType.binToDec
                      ? Colors.green
                      : isDecimalHovered
                          ? Colors.deepPurple
                          : Colors.grey,
                ),
              ),
              labelText: 'Decimal Number',
              labelStyle: TextStyle(
                color: getBinToDecLabelColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  binaryNumber() {
    return SizedBox(
      width: MediaQuery.of(context).size.width < 900
          ? MediaQuery.of(context).size.width / 1.5
          : 400,
      child: MouseRegion(
        onEnter: (event) => setState(() {
          isBinaryHovered = true;
        }),
        onExit: (event) => setState(() {
          isBinaryHovered = false;
        }),
        child: TextField(
          focusNode: _focusBin,
          readOnly: converter == ConverterType.decToBin,
          style: TextStyle(
            color: widget.themeChangeProvider.darkTheme
                ? Colors.white
                : Colors.black,
          ),
          controller: _binController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp("[0-1]"),
            ),
          ],
          decoration: InputDecoration(
            icon: _binController.text.isNotEmpty &&
                    converter == ConverterType.decToBin
                ? copyButton(_binController)
                : null,
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: converter == ConverterType.decToBin
                    ? Colors.green
                    : Colors.deepPurple,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: converter == ConverterType.decToBin
                    ? Colors.green
                    : isBinaryHovered
                        ? Colors.deepPurple
                        : Colors.grey,
              ),
            ),
            labelText: 'Binary Number',
            labelStyle: TextStyle(
              color: getDecToBinLabelColor(),
            ),
          ),
        ),
      ),
    );
  }

  IconButton copyButton(TextEditingController controller) {
    return IconButton(
      icon: Icon(
        Icons.copy,
        color: isDecimalHovered && controller == _decController
            ? Colors.green
            : isBinaryHovered && controller == _binController
                ? Colors.green
                : widget.themeChangeProvider.darkTheme
                    ? Colors.white
                    : Colors.black,
      ),
      onPressed: () async {
        _copyToClipboard(controller);
      },
    );
  }

  void _binConverter() {
    String decimal = _decController.text;
    String binary = _binController.text;

    if (decimal.isNotEmpty || binary.isNotEmpty) {
      switch (converter) {
        case ConverterType.binToDec:
          int? parsedBinary = int.tryParse(binary, radix: 2);

          if (parsedBinary != null) {
            setState(() {
              _decController.text = parsedBinary.toString();
            });
          } else {
            setState(() {
              _decController.text = '';
            });
          }
        case ConverterType.decToBin:
          int? parsedDecimal = int.tryParse(decimal);
          if (parsedDecimal != null) {
            setState(() {
              _binController.text = decimalToBinary(parsedDecimal);
            });
          } else {
            setState(() {
              _binController.text = '';
            });
          }
      }
    }
  }

  String decimalToBinary(int decimal) {
    String binary = '';

    while (decimal > 0) {
      int remainder = decimal % 2;
      binary = '$remainder$binary';
      decimal = (decimal / 2).floor();
    }

    return binary;
  }

  Future<void> _copyToClipboard(TextEditingController controller) async {
    await Clipboard.setData(ClipboardData(text: controller.text));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
      backgroundColor: Colors.green,
    ));
  }

  Color getDecToBinLabelColor() {
    if (converter == ConverterType.decToBin) {
      return widget.themeChangeProvider.darkTheme ? Colors.white : Colors.black;
    } else {
      return isBinaryHovered || isBinFocused
          ? Colors.deepPurple
          : widget.themeChangeProvider.darkTheme
              ? Colors.grey
              : Colors.black;
    }
  }

  Color getBinToDecLabelColor() {
    if (converter == ConverterType.binToDec) {
      return widget.themeChangeProvider.darkTheme ? Colors.white : Colors.black;
    } else {
      return isDecimalHovered || isDecFocused
          ? Colors.deepPurple
          : widget.themeChangeProvider.darkTheme
              ? Colors.grey
              : Colors.black;
    }
  }

  Widget title(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width > 700
            ? MediaQuery.of(context).size.height / 50
            : 140,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Binary converter',
            style: GoogleFonts.poppins(
              color: widget.themeChangeProvider.darkTheme
                  ? Colors.deepPurple
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
