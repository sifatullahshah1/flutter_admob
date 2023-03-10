import 'package:flutter/material.dart';
import 'package:flutter_admob/admob/admob_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ScreenIntertitialAds extends StatefulWidget {
  const ScreenIntertitialAds({Key? key}) : super(key: key);

  @override
  State<ScreenIntertitialAds> createState() => _ScreenIntertitialAdsState();
}

class _ScreenIntertitialAdsState extends State<ScreenIntertitialAds> {
  late InterstitialAd _interstitialAd;
  bool isIntertitialAdsLoad = false;

  intetStitialAdsLoad() {
    InterstitialAd.load(
      adUnitId: AdmobManager.inter_id,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          isIntertitialAdsLoad = true;

          _interstitialAd.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            _interstitialAd.dispose();
            print("object_object onAdDismissedFullScreenContent");
          }, onAdFailedToShowFullScreenContent: (ad, error) {
            print("object_object ${error.toString()}");
          });
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  initState() {
    super.initState();

intetStitialAdsLoad();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isIntertitialAdsLoad) {
          _interstitialAd.show();
        }
        return null!;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              if (isIntertitialAdsLoad) {
                _interstitialAd.show();
              }
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text("Intertitial Ads"),
        ),
      ),
    );
  }
}
