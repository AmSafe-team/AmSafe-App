import 'package:amsafe/controller/auth_controller.dart';
import 'package:amsafe/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //! Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AmSafe',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            useMaterial3: true,
          ),
          home: SplashPage(),
        );
      },
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
