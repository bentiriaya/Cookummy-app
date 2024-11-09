import 'package:Cookummy/routes/routesnames.dart';
import 'package:Cookummy/views/myrecipesDetails.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/addRecipes.dart';
import '../views/home.dart';
import '../views/recipesDetails.dart';
import '../views/splashScreen.dart';

routes()=>[
  GetPage(name: namesRoute.splash, page: () => const SplashScreen()),
  GetPage(name: namesRoute.home, page: () => const Home()),
  GetPage(name: namesRoute.detailRec, page: () => RecipeDetailsPage()),
  GetPage(name: namesRoute.addRec, page:()=> AddRecipePage()),// Page de détails de la recette
  GetPage(name: namesRoute.myrecDet, page:()=> MyRecipeDetailsPage())
];


