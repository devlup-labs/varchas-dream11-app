import 'package:flutter/material.dart';

const primaryColor = Color(0xFF212121);
const primaryColorLight = Color(0xFF484848);
const secondaryColor = Color(0xFFEF6C00);
const secondaryColorLight = Color(0xFFFF9D3F);
const secondaryColorLighter = Color(0x60FF9D3F);
const primaryColorLighter = Color(0xFFAAAAAA);

const Map<String, String> sportChoices = {
  '5': 'cricket',
  '6': 'football',
  '3': 'basketball',
  '2': 'badminton',
  '7': 'tableTennis',
  '8': 'tennis',
  '4': 'chess',
  '1': 'athletics',
  '9': 'volleyball',
};

//Medium font text styles
const kMediumTextStyleBlack = TextStyle(
  fontFamily: 'OpenSans Medium',
  color: Colors.black,
  fontSize: 16.0,
);

const kMediumTextStyleWhite = TextStyle(
  fontFamily: 'OpenSans Medium',
  color: Colors.white,
  fontSize: 16.0,
);

const kMediumTextStyleOrange = TextStyle(
  fontFamily: 'OpenSans Medium',
  color: secondaryColor,
  fontSize: 16.0,
);

//Regular font text styles
const kLabelTextStyleBlack = TextStyle(
  fontFamily: 'OpenSans Regular',
  color: Colors.black,
  fontSize: 16.0,
);

const kLabelTextStyleWhite = TextStyle(
  fontFamily: 'OpenSans Regular',
  color: Colors.white,
  fontSize: 16.0,
);

//Thin font text styles
const kPointsTextStyleBlack = TextStyle(
  fontFamily: 'OpenSans Light',
  color: Colors.black,
  fontSize: 22.0,
);

const kPointsTextStyleWhite = TextStyle(
  fontFamily: 'OpenSans Light',
  color: Colors.white,
  fontSize: 22.0,
);

const kTeamNameTextStyleWhite = TextStyle(
  fontFamily: 'OpenSans Light',
  color: Colors.white,
  fontSize: 15.0,
  fontWeight: FontWeight.w800,
);
