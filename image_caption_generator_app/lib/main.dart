import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app/config/colors.dart';
import 'app/modules/connectivity/connectivity_view.dart';
import 'app/services/storage/services.dart';
import 'app/widgets/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: Alignment.bottomCenter,
          textDirection: TextDirection.ltr,
          children: [
            GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Image Caption Generator',
              theme: ThemeData(
                primaryColor: primaryColor,
                fontFamily: 'Outfit',
                // change the theme from blue to primaryColor
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: primaryColor,
                  secondary: secondaryColor,
                ),
                dialogTheme: const DialogTheme(
                  elevation: 0,
                ),

                indicatorColor: primaryColor,
              ),
              home: Builder(
                builder: (context) => const SplashScreen(),
              ),
              defaultTransition: Transition.fadeIn,
            ),
            const ConnectivityView()
          ],
        ),
      ),
    );
  }
}
