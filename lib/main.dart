import 'dart:convert';

import 'package:agendavue/controllers/general_controller.dart';
import 'package:agendavue/presentation/district_dark_screen/controller/district_dark_controller.dart';
import 'package:agendavue/presentation/splash_dark_screen/splash_dark_screen.dart';
import 'package:agendavue/theme_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

//entry point of the app in flutter
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Paint.enableDithering = true;
  await GetStorage.init();
  Get.put(GeneralController());
  Get.put(DistrictDarkController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgendaVue',
      home: SplashDarkScreen(),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Palette.cToDark,
        colorScheme: const ColorScheme.light().copyWith(
          primary: Palette.cToDark,
          secondary: Palette.cToDark,
        ),
      ),
    );
  }
}
Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}