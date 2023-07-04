import 'package:amazon_app/constants/global%20variable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: globalvariable.backgroundColor,
          colorScheme:
              ColorScheme.light(
                primary: globalvariable.secondaryColor,
                ),
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("AMAZON CLONE"),
          ),
          body: Column(
            children: [
              Center(
                child: Text("flutter app"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("CLICK ME"),
              )
            ],
          ),
        ));
  }
}
