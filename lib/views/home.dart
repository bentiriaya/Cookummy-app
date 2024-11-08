import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/views/widgets/bottomNavigation.dart';
import 'package:get/get.dart';
import '../../Controllers/navigationController.dart'; // Importer le controller

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.put(NavigationController()); // Récupérer le controller

    return Scaffold(

      body: Obx(() => navigationController.currentChild), // Listen to child changes
      bottomNavigationBar: BottomNav(), // Your BottomNav widget
    );
  }
}
