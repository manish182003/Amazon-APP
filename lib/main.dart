import 'package:amazon_app/common/widgets/bottom_bar.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/admin/screens/admin_screen.dart';
import 'package:amazon_app/features/auth/screens/auth_screen.dart';
import 'package:amazon_app/features/auth/services/auth_service.dart';

import 'package:amazon_app/provider/user_provider.dart';
import 'package:amazon_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final authservice Authservice = authservice();
  @override
  void initState() {
    super.initState();
    Authservice.getuserdata(context);
  }

  Widget build(BuildContext context) {
  
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: globalvariable.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: globalvariable.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateroute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? Bottombar()
              : adminscreen()
          : const authscreen(),
    );
  }
}


