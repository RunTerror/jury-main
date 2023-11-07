import 'package:flutter/material.dart';

double make_responsive(String select, double dimension, BuildContext context) {
  var width3 = MediaQuery.of(context).size.width;

  var height = MediaQuery.of(context).size.height;
  if (select == 'w') {
    return width3 * (dimension / 428);
  }
  return height * (dimension / 926);
}
