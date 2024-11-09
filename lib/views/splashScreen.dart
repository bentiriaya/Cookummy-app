import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Cookummy/Controllers/SplashScreenController.dart';
import 'package:Cookummy/data/colors.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller){
          return Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width/2,height:MediaQuery.sizeOf(context).height/2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:AssetImage("assets/cookumy.png")
                  )
              ),),
          );
        },
      ),
    )  ;
  }
}
