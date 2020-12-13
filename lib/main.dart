import 'package:flutter/material.dart';
import 'package:github_assistant/Views/search_page.dart';

import 'Helpers/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Assistant',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppColors.mainColor,
        primaryColor: AppColors.secondColor,
      ),
      home: SearchPage(),
    );
  }
}
