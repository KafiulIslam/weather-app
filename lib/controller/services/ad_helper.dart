import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
        //String realAdUnitId = "ca-app-pub-6871786334119508/5784100136";
        String testAdUnitId = "ca-app-pub-3940256099942544/6300978111";
      return testAdUnitId;
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
        //String realInterstitialAdUnit = "ca-app-pub-6871786334119508/4180224480";
         String defaultInterstitialAdUnit = "ca-app-pub-3940256099942544/1033173712";
      return defaultInterstitialAdUnit;
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

}