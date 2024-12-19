import 'package:flutter_admod_demo/exports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();
  RequestConfiguration configuration = RequestConfiguration(testDeviceIds: ['1e931ba7-140f-4a3a-b04a-00fdfddfe8db']);
  MobileAds.instance.updateRequestConfiguration(configuration);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
