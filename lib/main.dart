import 'package:flutter/material.dart';
import 'package:rapid_read/constants.dart';

import 'Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.appbarfgcolor,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
