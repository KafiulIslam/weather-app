import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_forecasting_app/controller/constant/color.dart';
import 'package:weather_forecasting_app/view/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecasting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
          duration: 1000,
           splash: 'assets/images/weather_logo.png',
          nextScreen: HomeScreen(),
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: lightModeDeepColor),
    );
  }
}


