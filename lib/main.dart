import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/pages/home_page.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('ToDoBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  final _settingsBox = Hive.box('ToDoBox');

  @override
  void initState() {
    super.initState();
    isDarkMode = _settingsBox.get('isDarkMode', defaultValue: true);
  }

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
      _settingsBox.put('isDarkMode', isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
    );
  }
}
