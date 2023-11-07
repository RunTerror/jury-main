import 'package:flutter/material.dart';

class Constants {
  // Colors

  static Color orange = fromHex('#95602A');

  static Color yellow = fromHex('#c99f4a');

  static Color black = fromHex('#000000');

  static Color white = fromHex('#FAFAFA');

  static Color black33 = fromHex('#33050125');

  static Color black4c = fromHex('#4c000000');

  static Color lightblack = fromHex('#050125');

  static Color blue = fromHex('#2196F3');

  static Color grey900 = fromHex('#212121');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Fonts
  static TextStyle satoshiNormal30 = const TextStyle(
    color: Color(0xCF1B1464),
    fontSize: 30,
    fontFamily: 'Satoshi',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static TextStyle satoshiWhiteNormal23 = TextStyle(
    color: Constants.white,
    fontSize: 23,
    fontFamily: 'Satoshi',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static TextStyle satoshiYellowNormal22 = TextStyle(
    color: Constants.yellow,
    fontSize: 22,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static TextStyle satoshiBlackNormal18 = TextStyle(
    color: Constants.black,
    fontSize: 18,
    fontFamily: 'Satoshi',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static TextStyle satoshiLightBlackNormal14 = TextStyle(
    color: Constants.lightblack,
    fontSize: 14,
    fontFamily: 'Satoshi',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle satoshiLightBlackNormal18 = TextStyle(
    color: Constants.lightblack,
    fontSize: 18,
    fontFamily: 'Satoshi',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle satoshiLightBlackNormal22 = TextStyle(
    color: Constants.lightblack,
    fontSize: 22,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static TextStyle satoshiYellow14 = TextStyle(
    color: Constants.yellow,
    fontSize: 14,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
  );

  static TextStyle satoshiTransparentNormal22Underline = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Constants.yellow,
    decorationThickness: 2.5,
    shadows: [
      Shadow(
        color: Constants.yellow,
        offset: const Offset(0, -5),
      )
    ],
    color: Colors.transparent,
    fontSize: 22,
    fontFamily: 'Satoshi',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static TextStyle satoshiWhite18 = TextStyle(
    color: Constants.white,
    fontSize: 18,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
  );

  static TextStyle satoshiGrey90016 = TextStyle(
    color: Constants.grey900,
    fontSize: 16,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
  );

  static TextStyle lightBlackBold = TextStyle(
    color: Constants.lightblack,
    fontWeight: FontWeight.bold,
  );

  static TextStyle satoshiYellowUnderline14 = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Constants.yellow,
    decorationThickness: 2.5,
    shadows: [
      Shadow(
        color: Constants.yellow,
        offset: const Offset(0, -5),
      ),
    ],
    color: Colors.transparent,
    fontSize: 14,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
  );
}
