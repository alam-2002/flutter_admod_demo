import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2194510708093155/8104935933';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2194510708093155/1755150005';
    } else {
      throw UnsupportedError('Unsupported Platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2194510708093155/3783413518';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2194510708093155/6421153328';
    } else {
      throw UnsupportedError('Unsupported Platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2194510708093155/2035185752';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2194510708093155/7623683652';
    } else {
      throw UnsupportedError('Unsupported Platform');
    }
  }
}
/*

Google's Test Ad Unit IDs
Banner: ca-app-pub-3940256099942544/6300978111
Interstitial: ca-app-pub-3940256099942544/1033173712
Rewarded: ca-app-pub-3940256099942544/5224354917
Native Advanced: ca-app-pub-3940256099942544/2247696110

 */
