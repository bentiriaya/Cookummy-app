import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:Cookummy/data/colors.dart';

import 'package:get/get.dart';
import '../../Controllers/navigationController.dart';


class BottomNav extends StatelessWidget {
  BottomNav({super.key});


  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return
        FluidNavBar(
          icons:   [
            FluidNavBarIcon(icon: Icons.restaurant),
            FluidNavBarIcon(icon: Icons.add),
            FluidNavBarIcon(icon: Icons.favorite),
          ],
          onChange: navigationController.handleNavigationChange,
          style: FluidNavBarStyle(
              barBackgroundColor: color.bgColor,
              iconBackgroundColor: Colors.white,
              iconSelectedForegroundColor: color.yellow,
              iconUnselectedForegroundColor: color.grey,
          ),
        );

  }
}
