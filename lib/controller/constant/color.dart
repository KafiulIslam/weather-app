import 'package:flutter/material.dart';

const darkModeDeepColor = Color(0xFF292E49);
const darkModeLightColor = Color(0xFF505671);

const lightModeDeepColor = Color(0xFF02D2FF);
const lightModeLightColor = Color(0xFF75E4FC);



const assColor = Color(0xFF84828D);


const darkMode = LinearGradient(
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
  colors: [
    darkModeDeepColor,
    darkModeLightColor,
  ],

);

const lightMode = LinearGradient(
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
  colors: [
    lightModeLightColor,
    lightModeDeepColor,
  ],

);