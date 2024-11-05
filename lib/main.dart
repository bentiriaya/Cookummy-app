import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/route.dart';
import 'package:flutter_application_1/views/addRecipes.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/splashScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'Services/sharedperfsManagers.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisez et enregistrez SharedperfManager
  await Get.putAsync(() => SharedperfManager().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: routes(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}