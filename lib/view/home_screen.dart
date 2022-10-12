import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forecasting_app/controller/state/weather_result_state.dart';
import 'package:weather_forecasting_app/view/result_screen.dart';
import '../controller/component/primary_button.dart';
import '../controller/component/primary_spacer.dart';
import '../controller/constant/color.dart';



class HomeScreen extends StatefulWidget {
    HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   WeatherResultState stateController = Get.put(WeatherResultState());
   late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<WeatherResultState>(builder: (_){
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: stateController.isDarkMode == true ? darkMode : lightMode,
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildToggleButton(context),
                      const PrimaryVerticalSpacer(),
                      _searchBar(context),
                      const PrimaryVerticalSpacer(),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                              AssetImage('assets/images/cloudwithquestion.png'),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Text(
                        'Enter Your Location',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lobster(
                            textStyle: const TextStyle(
                                fontSize: 60,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      ),
                      const PrimaryVerticalSpacer(),
                      PrimaryButton(
                        onTap: () {
                          setState(() {
                            _isLoading = true;
                          });
                            Future.delayed(const Duration(milliseconds: 1000), () {
                              Get.to(()=> ResultScreen());
                              stateController.loadWeatherData();
                              stateController.getDate();
                              _isLoading = false;
                            });
                        },
                    isLoading:  _isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }

    Widget _searchBar(BuildContext context) {
      return TextFormField(
        controller: stateController.locationController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Enter your location',
          hintStyle: const TextStyle(
              color: assColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          prefixIcon: Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color:  Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color:  Colors.transparent),
          ),
          focusColor: Colors.blue,
        ),
      );
    }

  Widget _buildToggleButton(BuildContext context) {
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
}
