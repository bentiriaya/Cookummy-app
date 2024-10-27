import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/home.dart';
import '../views/recipesDetails.dart';
import '../views/splashScreen.dart';

routes()=>[
  GetPage(name: namesRoute.splash, page: () => const SplashScreen()),
  GetPage(name: namesRoute.home, page: () => const Home()),
  GetPage(name: namesRoute.detailRec, page: () => RecipeDetailsPage()) // Page de détails de la recette
];


