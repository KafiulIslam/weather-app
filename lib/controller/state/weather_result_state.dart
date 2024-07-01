import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../services/weather_api_client.dart';

class WeatherResultState extends GetxController{

 // TextEditingController locationController = TextEditingController();

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

      String _location = '';
  String get location => _location;

      double _temperature = 0.0;
      double get temperature => _temperature;

      double _max = 0.0;
      double get max => _max;

      double _min = 0.0;
      double get min => _min;

      int _pressure = 0;
       int get pressure => _pressure;

      int _humidity = 0;
      int get humidity => _humidity;

      double _windSpeed = 0.0;
      double get windSpeed => _windSpeed;

      int _windDeg = 0;
      int get windDeg => _windDeg;

      var _rain = 0.0;
      get rain => _rain;


      int _cloud = 0;
      int get cloud => _cloud;

      String _base = 'Unknown';
      String get base => _base;


      late bool _isDataLoading = false;
      bool get isDataLoading => _isDataLoading;
  Future<void> loadWeatherData(String location) async {
   try{
     _isDataLoading = true;
     update();

     var weatherData = await getWeatherInfo(location);
     _location = weatherData['data']['name'];
     _temperature = weatherData['data']['main']['temp'] - 273.15 ?? 0.00;
     _max = weatherData['data']['main']['temp_max'] - 273.15;
     _min = weatherData['data']['main']['temp_min'] - 273.15;
     _pressure = weatherData['data']['main']['pressure'];
     _humidity = weatherData['data']['main']['humidity'];
     _windSpeed = weatherData['data']['wind']['speed'];
     _windDeg = weatherData['data']['wind']['deg'];
     // _rain = weatherData['data']['rain']['1h'] ?? 0;
     _cloud = weatherData['data']['clouds']['all'];
     _base = weatherData['data']['base'];
     update();
   }catch(e){
     print(e);
   }finally{
     _isDataLoading = false;
     update();
   }

  }


  bool isLoading = false;
  void getCircular (){
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 1000), () {
      isLoading = false;
    });
  }

}