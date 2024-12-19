import 'package:flutter_admod_demo/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _bannerAd;
  bool isBannerAdReady = false;

  late InterstitialAd _interstitialAd;
  bool isInterstitialAdReady = false;

  late RewardedAd _rewardedAd;
  bool isRewardedAdReady = false;

  int _rewardedScore = 0;

  @override
  void initState() {
    // BannerAd
    _loadBannerAd();

    // InterstitialAd
    _loadInterstitialAd();

    // RewardedAd
    _loadRewardedAd();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();

    if (isBannerAdReady || isRewardedAdReady) {
      _interstitialAd.dispose();
    }

    if (isBannerAdReady || isInterstitialAdReady) {
      _rewardedAd.dispose();
    }

    super.dispose();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      // adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            // _bannerAd = ad as BannerAd;
            isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Failed to load BannerAd --> $error');
          isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      // adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
            isInterstitialAdReady = true;
          });
        },
        onAdFailedToLoad: (error) {
          print('Failed to load InterstitialAd --> $error');
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (isInterstitialAdReady) {
      _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          setState(() {
            isInterstitialAdReady = false;
          });

          // load new InterstitialAd
          _loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print('Failed to load InterstitialAd --> $error');
          setState(() {
            isInterstitialAdReady = false;
          });
        },
      );

      _interstitialAd.show();

      setState(() {
        isInterstitialAdReady = false;
      });
    }
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      // adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _rewardedAd = ad;
            isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (error) {
          print('Failed to load RewardedAd --> $error');
          isRewardedAdReady = false;
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (isRewardedAdReady) {
      _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          setState(() {
            isRewardedAdReady = false;
          });

          // load new RewardedAd
          _loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print('Failed to load RewardedAd --> $error');
          setState(() {
            isRewardedAdReady = false;
          });
        },
      );

      _rewardedAd.show(
        onUserEarnedReward: (ad, reward) {
          setState(() {
            _rewardedScore++;
          });
        },
      );

      setState(() {
        isRewardedAdReady = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Center(
              child: Text(
                'Rewarded Score = $_rewardedScore',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('_showInterstitialAd pressed');
                _showInterstitialAd();
              },
              child: Text('Show Interstitial Ad'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('_showRewardedAd pressed');
                _showRewardedAd();
              },
              child: Text('Show Rewarded Ad'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isBannerAdReady
          ? SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
