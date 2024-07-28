import 'package:flutter/material.dart';
import 'package:weather_app/views/DetailPage.dart';
import 'package:weather_app/views/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'detail_page': (context) => DetailPage(),
      },
    ),
  );
}
