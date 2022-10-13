import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:weather_forecasting_app/view/result/result_widget/info_row.dart';
import '../../controller/component/primary_button.dart';
import '../../controller/component/primary_spacer.dart';
import '../../controller/constant/color.dart';
import '../../controller/constant/typography.dart';
import '../../controller/services/weather_api_client.dart';
import '../../controller/state/weather_result_state.dart';


class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key,}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  WeatherResultState stateController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder<WeatherResultState>(builder: (_) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: stateController.isDarkMode == true
                    ? darkMode
                    : lightMode,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                    _buildToggleSwitch(context),
                     _tempResult(context),
                    _glassCard(context),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {
          Get.back();
        },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 25,)),
        FlutterSwitch(
          width: 55.0,
          height: 25.0,
          toggleSize: 20.0,
          value: stateController.isDarkMode,
          borderRadius: 30.0,
          padding: 4.0,
          activeToggleColor: Colors.white,
          inactiveToggleColor: Colors.white,
          activeColor: lightModeDeepColor,
          inactiveColor: darkModeDeepColor,
          activeIcon: const Icon(
            Icons.nightlight_round,
            color: Color(0xFFFFDF5D),
          ),
          inactiveIcon: const Icon(
            Icons.wb_sunny,
            color: Color(0xFFFFDF5D),
          ),
          onToggle: (val) {
            stateController.modeToggle();
          },
        ),
      ],);
  }

  Widget _tempResult(BuildContext context) {
    return Column(children: [
      Image.asset('assets/images/cloud.png', height: MediaQuery
          .of(context)
          .size
          .height / 4,
          width: MediaQuery
              .of(context)
              .size
              .height / 2,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(stateController.temperature.toStringAsFixed(2),
            style: header1,),
          const Padding(
            padding: EdgeInsets.only(left: 4.0, bottom: 32),
            child: Text('o', style: sixteenWhiteStyle,),
          )
        ],),
      Text( stateController.location, style: header2,),
      Text(
        stateController.dateTime, style: sixteenWhiteStyle,),
    ],);
  }

 Widget _glassCard(BuildContext context) {
    return GlassmorphicFlexContainer(
      borderRadius: 20,
      blur: 20,
      padding: EdgeInsets.all(16),
      alignment: Alignment.bottomCenter,
      border: 0.5,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.1),
            Color(0xFFFFFFFF).withOpacity(0.05),
          ],
          stops: [
            0.1,
            1,
          ]),
      borderGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          Colors.transparent,
        ],
      ),
      child: Column(
         mainAxisSize: MainAxisSize.min,
        children: [
          InfoRow(data1: 'Max: ${stateController.max.toStringAsFixed(2)}',data2: 'Min: ${ stateController.min.toStringAsFixed(2)}',),
          Expanded(child: Divider(color: stateController.isDarkMode == true ? darkModeDeepColor : lightModeDeepColor, height: 0.5,)),
          InfoRow(data1: 'Pressure: ${ stateController.pressure.toStringAsFixed(2)}',data2: 'Humidity: ${ stateController.humidity.toStringAsFixed(2)}',),
          Expanded(child: Divider(color: stateController.isDarkMode == true ? darkModeDeepColor : lightModeDeepColor, height: 0.5,)),
          InfoRow(data1: 'Wind Speed: ${ stateController.windSpeed.toStringAsFixed(2)}',data2: 'Wind deg: ${ stateController.windDeg.toStringAsFixed(2)}',),
          Expanded(child: Divider(color: stateController.isDarkMode == true ? darkModeDeepColor : lightModeDeepColor, height: 0.5,)),
          InfoRow(data1: 'Rain: ${ stateController.rain.toStringAsFixed(2)}',data2: 'Clouds: ${ stateController.cloud.toStringAsFixed(2)}',),
          Expanded(child: Divider(color: stateController.isDarkMode == true ? darkModeDeepColor : lightModeDeepColor, height: 0.5,)),
          InfoRow(data1: 'Base',data2:  stateController.base,),
      ],),
    );
 }

}
