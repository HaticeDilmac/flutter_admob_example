import 'package:flutter/material.dart';
import 'package:flutter_admob_example/admob/googleAds.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GoogleAdds _googleAds = GoogleAdds();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _googleAds.loadInterstitialAd();
    _googleAds.loadBannerAd(onAdLoaded: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      appBar: AppBar(
        title: const Text('AdMob'),
        backgroundColor: const Color.fromARGB(255, 158, 128, 167),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ), //Banner değişkeni null değilse
            if (_googleAds.bannerAd != null)
              Container(
                color: Colors.white,
                width: 468,
                height: 60,
                child: AdWidget(
                    ad: _googleAds
                        .bannerAd!), //Widget olarak belirlenen ölçülerde bannerı ekle
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _googleAds.showInterstitalAd();

          //sabit resimli reklamı gçster fonksiyonunu aktif ederiz.

          _incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
