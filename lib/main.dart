import 'package:flutter/material.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/utils/redd_button.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
// initialise the hive
  await Hive.initFlutter();

 await Hive.openBox('ToDoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}