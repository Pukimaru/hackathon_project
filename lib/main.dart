import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hackathon_project/object/transactionData.dart';
import 'package:hackathon_project/screen/ChatBotScreen.dart';
import 'package:hackathon_project/screen/SettingScreen.dart';
import 'package:hackathon_project/screen/SetupScreen.dart';
import 'package:hackathon_project/widget/transactionCard.dart';

import 'dial/uploadDial.dart';
import 'util/const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Dashboard',
      theme: ThemeData(
        primaryColor: Color(0xFF6EC1E4),
        scaffoldBackgroundColor: Color(0xFFF7FAFC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF6EC1E4),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: SetupScreen(),
    );
  }
}

