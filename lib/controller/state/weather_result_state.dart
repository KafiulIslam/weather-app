import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../services/weather_api_client.dart';

class WeatherResultState extends GetxController{

  TextEditingController locationController = TextEditingController();

  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;
  void modeToggle (){
      _isDarkMode = !_isDarkMode;
      var index = 0;
      if (!_isDarkMode) {
        index = 1;
      }
      update();
   }


    String dateTime = '';
  void getDate() {
    DateTime currentDateTime = DateTime.now();
    var formatDate = DateFormat('EEEE, d MMM, yyyy').format(currentDateTime);
    dateTime = formatDate;
  }


    String location = '';
    double temperature = 0.0;
  Future<void> loadWeatherData() async {
    var weatherData = await getWeatherInfo(locationController.text);
       location = weatherData['data']['name'];
       temperature = weatherData['data']['main']['temp'] - 273.15;
       update();
  }


  // bool isLoading = false;
  // void getCircular (){
  //   isLoading = true;
  //   Future.delayed(const Duration(milliseconds: 1000), () {
  //     isLoading = false;
  //   });
  // }

}