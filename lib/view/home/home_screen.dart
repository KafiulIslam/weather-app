import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weather_forecasting_app/controller/state/weather_result_state.dart';
import 'package:weather_forecasting_app/view/result/result_screen.dart';
import '../../controller/component/primary_button.dart';
import '../../controller/component/primary_spacer.dart';
import '../../controller/constant/color.dart';
import '../../controller/services/ad_helper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherResultState stateController = Get.put(WeatherResultState());
  late bool _isLoading = false;
 // late Position currentPosition;
  late TextEditingController locationController =
      TextEditingController();

  // Future<void> locationPermissionHandler() async {
  //   if (await Permission.location.serviceStatus.isEnabled) {
  //     PermissionStatus status = await Permission.location.status;
  //     if (status.isGranted) {
  //       Position position = await Geolocator.getCurrentPosition();
  //       setState(() {
  //         currentPosition = position;
  //       });
  //       // setState(() {
  //       //   currentPosition = LatLng(position.latitude, position.longitude);
  //       // });
  //     } else if (status.isDenied) {
  //       PermissionStatus permissionStatus =
  //       await Permission.locationWhenInUse.request();
  //       locationPermissionHandler();
  //     }
  //   } else {
  //     PermissionStatus permissionStatus =
  //     await Permission.locationWhenInUse.request();
  //     locationPermissionHandler();
  //   }
  // }
  //
  // void getPlacemarks(double lat, double long, bool isMarker) async {
  //   try {
  //     setState(() {
  //       isAddressDetailsLoading = true;
  //     });
  //
  //     List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
  //
  //     var address = '';
  //
  //     if (placemarks.isNotEmpty) {
  //       var streets = placemarks.reversed
  //           .map((placemark) => placemark.street)
  //           .where((street) => street != null);
  //
  //       streets = streets.where((street) =>
  //       street!.toLowerCase() !=
  //           placemarks.reversed.last.locality!
  //               .toLowerCase()); // Remove city names
  //       streets = streets
  //           .where((street) => !street!.contains('+')); // Remove street codes
  //
  //       address += streets.join(', ');
  //
  //       //address += ', ${placemarks.reversed.last.subLocality ?? ''}';
  //       //address += ', ${placemarks.reversed.last.locality ?? ''}';
  //       address += ' ${placemarks.reversed.last.subAdministrativeArea ?? ''}';
  //       address += ', ${placemarks.reversed.last.administrativeArea ?? ''}';
  //       //address += ', ${placemarks.reversed.last.postalCode ?? ''}';
  //       address += ', ${placemarks.reversed.last.country ?? ''}';
  //     }
  //
  //     if (!isMarker) {
  //       return null;
  //     } else {
  //       setState(() {
  //         _searchController.text = address;
  //       });
  //     }
  //   } catch (e) {
  //     CustomSnack.warningSnack(e.toString());
  //   } finally {
  //     setState(() {
  //       isAddressDetailsLoading = false;
  //     });
  //   }
  // }


  /// google add ///

  InterstitialAd? _interstitialAd;
  late int _interstitialLoadAttempts = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      // adUnitId: "ca-app-pub-3940256099942544/8691691433",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts++;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= 3) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    _createInterstitialAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: GetBuilder<WeatherResultState>(builder: (_) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: stateController.isDarkMode == true ? darkMode : lightMode,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
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
                            image: AssetImage(
                                'assets/images/cloudwithquestion.png'),
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
                            stateController
                                .loadWeatherData(locationController.text);
                            stateController.getDate();
                            Get.to(() => ResultScreen());
                            _showInterstitialAd();
                          },
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
      controller: locationController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Enter your location',
        hintStyle: const TextStyle(
            color: assColor, fontSize: 16, fontWeight: FontWeight.w500),
        prefixIcon: Icon(Icons.search),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusColor: Colors.blue,
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 10,
          width: 10,
        ),
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
      ],
    );
  }
}
