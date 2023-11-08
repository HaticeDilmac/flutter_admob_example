import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdds {
  InterstitialAd? _interstitialAd; //Sabit resimli reklam değişkeni

//Bu hangi platform kullanılacaksa platforma göre deneme reklam idsi eklenir
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  void loadInterstitialAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad; //değişkene atama yapılırl.
            if (showAfterLoad) showInterstitalAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showInterstitalAd() {
    if (_interstitialAd != null) {
      //eğer reklam değeri boş değilse
      _interstitialAd!.show(); //reklamı göster
    }
  }

  //-----------Banner Reklamı---------

  BannerAd? bannerAd; //Banner reklamının değişkeni
  //Bannera ait platforma göre idler
  final bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  /// Loads a banner ad.
  void loadBannerAd({required VoidCallback onAdLoaded}) {
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId, //platforma göre id
      request: const AdRequest(),
      size: AdSize
          .fullBanner, //banner boyutları- Alt alanı genişlik olarak full sarsın
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          onAdLoaded();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
}
