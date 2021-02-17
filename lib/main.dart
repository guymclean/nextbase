import 'package:flutter/material.dart';
import 'package:nextbase/di/custom_repo_provider.dart';
import 'package:nextbase/presentation/chart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomRepoProvider(
      child: MaterialApp(
        title: 'Nextbase App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ChartScreen(),
      ),
    );
  }
}
