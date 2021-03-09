import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

/// app name
const String kAppName = 'Azul Project';

/// gradien color

const kGradientBar = LinearGradient(
  colors: [
    kColorPrimaryDark,
    kColorPrimary,
  ],
);

///Styles

const kStyleCategory = TextStyle(
  color: kColorWhite,
  fontSize: 10.0,
  fontWeight: FontWeight.w600,
);
const kStyleTitlePost = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
  color: kColorBlack01,
);
const kStyleDecripPost = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
  color: kColorBlack01,
);

///convert date

String getDatePostNews(dateTime) {
  return '${DateFormat("dd MMM yyyy", 'ar').format(dateTime)}';
}

String getDatePostArticle(dateTime) {
  return '${DateFormat("HH:mm - dd/MM/yyyy").format(dateTime)}';
}
