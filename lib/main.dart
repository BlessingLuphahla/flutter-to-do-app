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
      home: const SignIn(),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var signInController = TextEditingController();

    void signIn() {
      if (signInController.text == 'reddaxe') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'This App Was Created by REDD AXE😎\nplease enter correct password 😗🤗',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ]),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: signInController,
                decoration: const InputDecoration(
                    hintText: 'Please Enter password here',
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
            width: double.infinity,
          ),
          ReddButton(
              buttonName: 'Press Here To Get inside the F🥱 App',
              onPressed: () => signIn()),
          const SizedBox(
            height: 100,
            width: double.infinity,
          ),
          const Text(
            'if password is wrong you won\'t get through',
            style: TextStyle(
              fontSize: 15,
              color: Colors.red,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    );
  }
}
