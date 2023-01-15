import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5562558287101607/8169816241';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5562558287101607/7086204409';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5562558287101607/3920781448";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


}