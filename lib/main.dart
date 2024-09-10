import 'package:amsafe/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //! Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AmSafe',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

extension AppTheme on ThemeData {
  Color get mainColor => Color(0xffDC213A);
  Color get whiteText => Color(0xffFFFFFF);
  Color get lightWhiteText => Color(0xffEEEDED);
  Color get blackText => Color(0xff020202);
  Color get lightBlackText => Color(0xff2F2F2F);
}
