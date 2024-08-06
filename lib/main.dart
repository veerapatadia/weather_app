import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/connectivityprovider.dart';
import 'package:weather_app/views/DetailPage.dart';
import 'package:weather_app/views/HomePage.dart';
import 'package:weather_app/views/splashscreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          'homepage': (context) => HomePage(),
          'detail_page': (context) => DetailPage(),
        },
      ),
    ),
  );
}
