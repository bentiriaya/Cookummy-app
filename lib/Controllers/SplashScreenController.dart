import 'package:flutter/material.dart';
import 'package:Cookummy/routes/routesnames.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {



  Future<void> goTo()async{
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(namesRoute.home);
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goTo();
    });
  }
}
