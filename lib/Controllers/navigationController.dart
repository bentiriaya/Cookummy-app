import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/strings.dart';
import '../views/favorite.dart';
import '../views/myRecipes.dart';
import '../views/ourRecipes.dart';

class NavigationController extends GetxController {
  // etat initial dyalhom
  final _currentIndex = 0.obs;
  final _appBarTitle = Data.accueil.obs;


  String get appBarTitle => _appBarTitle.value;

 //ela hsab index katrd file dyalo
  Widget get currentChild {
    switch (_currentIndex.value) {
      case 0:
        return ourRecipes();
      case 1:
        return myRecipes();
      case 2:
        return Favorites();
      default:
        return ourRecipes();
    }
  }

  //katbdl title
  void handleNavigationChange(int index) {

    _currentIndex.value = index;
    switch (index) {
      case 0:
        _appBarTitle.value = Data.accueil;
        break;
      case 1:
        _appBarTitle.value = Data.myrecipes;
        break;
      case 2:
        _appBarTitle.value = Data.favoris;
        break;
      default:
        _appBarTitle.value = "Our Recipes"; // Default title
        break;
    }
  }
}
