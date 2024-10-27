import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/widgets/type_card.dart';

class Data{
  static const String home="Home";
  static const String accueil="Inspirations";
  static const String myrecipes="Mes recettes";
  static const String favoris="Favoris";
  static const String name="cookummy";
  static const String logopath="cookumy.png";
  static const String tout="tout";
  static const String salade="Salade";
  static const String cake="Cake";
  static const String bisuits="Bisuits";
  static const String boulangerie="Boulangerie";
  static const String boissons="Boissons";
  static const String fastfood="Fastfood";
  static const String soupe="Soupe";
  static const String glace="Glace";
  static const Map<String, Icon> recipeTypes = {
    Data.tout:Icon(Icons.all_inbox),
    Data.salade: Icon(Icons.local_dining),
    Data.cake: Icon(Icons.cake),
    Data.bisuits: Icon(Icons.cookie),
    Data.boulangerie:Icon( Icons.bakery_dining),
    Data.boissons: Icon(Icons.local_bar),
    Data.fastfood: Icon(Icons.fastfood),
    Data.soupe: Icon(Icons.soup_kitchen),
  Data.glace:Icon(Icons.icecream)
  };



}