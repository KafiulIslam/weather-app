

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


class Main{
  double? temp;

  Main({this.temp});


  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;

    return data;
  }
}