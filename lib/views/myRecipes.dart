import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'addRecipes.dart';

class myRecipes extends StatelessWidget {
  const myRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Text("mine"
          ),
        ),
        Align(
          alignment: Alignment.bottomRight, // Aligne le bouton en bas à droite
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Ajouter un espacement
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(namesRoute.addRec);

              },
              backgroundColor: color.yellow, // Couleur de fond
              foregroundColor: Colors.white, // Couleur de l'icône
              elevation: 6, // Ombre du bouton
              child: Icon(Icons.add, size: 30),
            ),
          ),
        ),
      ],
    );
  }
}
