import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/component/primary_button.dart';
import '../controller/component/primary_spacer.dart';
import '../controller/constant/color.dart';
import '../controller/services/weather_api_client.dart';
import '../controller/state/weather_result_state.dart';


class ResultScreen extends StatelessWidget {
  ResultScreen({Key? key,}) : super(key: key);

  WeatherResultState stateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
           child: GetBuilder<WeatherResultState>(builder: (_){
             return Container(
               height: MediaQuery.of(context).size.height,
               width: double.infinity,
               decoration: BoxDecoration(
                 gradient: stateController.isDarkMode == true ? darkMode : lightMode,
               ),
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     _buildToggleSwitch(context),
                     _buildLocationDetails(context),
                     _tempResult(context),
                     PrimaryButton(
                       buttonTitle: 'Enter Location',
                       onTap: () {
                         Get.back();
                        },
                       isLoading: false,
                      ),
                   ],
                 ),
               ),
             );
           }),
        ),
      ),
    );
  }

  Widget  _buildToggleSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(height: 10,width: 10,),
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

  Widget _buildLocationDetails(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:   [
        PrimaryVerticalSpacer(),
        Text(stateController.location, style: const TextStyle(fontSize: 32,
          color: Colors.white,
          fontWeight: FontWeight.w800,),),
          Text(
          stateController.dateTime, style: const TextStyle(fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w800,),),
      ],),
    );
 }

  Widget _tempResult(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.height / 2,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cloud.png'),
            fit: BoxFit.contain,
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(stateController.temperature.toStringAsFixed(2),style: const TextStyle(fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.w800,),),
          const Padding(
            padding: EdgeInsets.only(left: 4.0,bottom: 32),
            child: Text('o',style: TextStyle(fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w800,),),
          )
        ],),
    );
 }

}
