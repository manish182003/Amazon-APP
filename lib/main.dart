import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/auth/screens/auth_screen.dart';
import 'package:amazon_app/routes.dart';
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
          colorScheme: const ColorScheme.light(
            primary: globalvariable.secondaryColor,
          ),
          appBarTheme:const AppBarTheme(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: (settings) => generateroute(settings),
        home:const authscreen()


           );
  }
}
