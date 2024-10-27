import 'package:flutter/material.dart';

class RecipeDetailsPage extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(""),
          SizedBox(height: 10),
          Text(
            "",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Cook Time: ',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          // Ajouter plus d'informations sur la recette ici si nécessaire
        ],
      ),
    );
  }
}
