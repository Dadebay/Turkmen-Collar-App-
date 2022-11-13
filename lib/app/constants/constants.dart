import 'package:flutter/material.dart';

const String serverURL = 'http://95.85.125.234:8765';

const Color kPrimaryColor = Color(0xfffd7e15);
const Color kPrimaryColorCard = Color.fromARGB(255, 240, 255, 246);
const Color kBlackColor = Color(0xff000000);
const Color kGreyColor = Color.fromARGB(255, 234, 234, 234);

///BorderRadius
const BorderRadius borderRadius5 = BorderRadius.all(Radius.circular(5));
const BorderRadius borderRadius10 = BorderRadius.all(Radius.circular(10));
const BorderRadius borderRadius15 = BorderRadius.all(Radius.circular(15));
const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(20));
const BorderRadius borderRadius25 = BorderRadius.all(Radius.circular(25));
const BorderRadius borderRadius30 = BorderRadius.all(Radius.circular(30));
/////////////////////////////////
const String normsProLight = 'NormsProLight';
const String normsProRegular = 'NormsProRegular';
const String normsProMedium = 'NormsProMedium';
const String normProBold = 'NormsProBold';
//Language icons
const String tmIcon = 'assets/image/tm.png';
const String ruIcon = 'assets/image/ru.png';
const String logo = 'assets/image/logo.png';
const String noData = 'assets/lottie/noData.json';
const String shareIcon = 'assets/icons/share1.png';
const String appName = 'ÝAKA';
const String appShareLink = 'https://drive.google.com/file/d/1g9_tSXWrnbpdDs49jIGteBOn4gl-J1ET/view?usp=sharing';
/////////////////////////////////////////////////

const List sortData = [
  {
    'id': 1,
    'name': 'sortDefault',
    'sort_column': '',
  },
  {
    'id': 2,
    'name': 'sortPriceLowToHigh',
    'sort_column': 'expensive',
  },
  {
    'id': 3,
    'name': 'sortPriceHighToLow',
    'sort_column': 'cheap',
  },
  {
    'id': 4,
    'name': 'sortCreatedAtHighToLow',
    'sort_column': 'latest',
  },
  {
    'id': 5,
    'name': 'sortCreatedAtLowToHigh',
    'sort_column': 'oldest',
  },
  {
    'id': 6,
    'name': 'sortViews',
    'sort_column': 'views',
  },
];
const List cities = [
  'Aşgabat',
  'Ahal',
  'Mary',
  'Lebap',
  'Daşoguz',
  'Balkan',
];
