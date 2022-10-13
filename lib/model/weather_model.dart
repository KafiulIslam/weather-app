

class WeatherModel{

  String? cityName;
  String? countryName;
  double? temp;
  String? condition;
  double? minTemp;
  double? maxTemp;

  WeatherModel({
    this.cityName,
    this.countryName,
    this.temp,
    this.condition,
    this.minTemp,
    this.maxTemp,
});

  WeatherModel.fromJson( Map<String, dynamic> json){

    cityName = json["name"];
    countryName = json["sys"]["country"];
    temp = json["main"]["temp"];
    condition = json["weather"]["main"];
    minTemp = json["main"]["temp_min"];
    maxTemp = json["main"]["temp_max"];

  }


}
