import 'package:flutter_application_1/data/strings.dart';

List<Map<String, dynamic>> recipes = [
  {
    "id": 1,
    "title": "Cake a la banane",
    "ingredients": [
      "250 g de farine",
      "160 g sucre",
      "1 sachet de levure",
      "1 pincée de sel",
      "3 bananes bien mures",
      "85 g de beurre",
      "2 cups lait",
      "2 oeufs"
    ],
    "instructions": "mixer tous les ingrédients ,\n"
        "ajouter les pépites de chocolet a la présentation\n"
        " puis mettre du papier cuisson dans le moule et verser la préparation ,\n"
        " enfourner 30 minutes",
    "imageUrl": "assets/imagesData/p1.jpg",
    "type": Data.cake,
    "cooktime":"30 min"
  },
  {
    "id": 2,
    "title": "cake fondant au chocolat",
    "ingredients": [
      "200 g chocolat noir",
      "125 g  beurre demi sel",
      "3 oeufs",
      "140 g sucre",
      "90 g  farine"
    ],
    "instructions": "préchauffer le four a 180 c\n"
        ",faire fondre  le chocloat et beurre an micro-onde,\n"
        "battre le sucre aves les oeufs puis ajouter le mélange de chocolat fondu et la farine,\n"
        "verser la pate dans un moule a cake préalablement beurré et enfourner pour 30 min",
    "imageUrl": "assets/imagesData/p2.jpg",
    "type": Data.cake,
    "cooktime":"30 min"
  },
  {
    "id": 3,
    "title": "pancakes",
    "ingredients": [
      "250 g farine",
      "1/2 g  sachet de leuvre",
      "2 oeufs",
      "75 g sucre",
      "40 cl  lait",
      "50 g  beurre"
    ],
    "instructions": "mélanger farine,leuvre et sucre dans un soldier \n"
        "puis ajouter lait les oeufs et le beurre ,\n"
        "faire cuire les pancakes dans une poele bien chaude",
    "imageUrl": "assets/imagesData/p5.jpg",
    "type": Data.cake,
    "cooktime":""
  },
  {
    "id": 4,
    "title": "salade césar",
    "ingredients": [
      "3 filets de poulets",
      "200 g de jeunes pousses de salade",
      "50 g de parmesan rapé",
      "2 gousses d'ail ",
      "2 oeufs cl  lait",
      "8 croutons ",
      "1 citron",
      "1 cuillère a soupe de moutarde"
    ],
    "instructions": "commencer par faire griller les filets de poulet avec un peu d'huile d'olive,\n"
        "en parallèle préparer une sauce avec le parmesan rapé,les gousses d'ail écrasées,les oeufs,le jus de citron et la moutarde\n"
        "laver et essorer les jeunes pousses de salade placez- les dans un grand saladier\n"
        "emettez les filets cuit sur les feuilles de salade puis verser la sauce sur le tout\n"
        "enfin ajouter les croutons sur le dessus de la salade et servez immédiatement",
    "imageUrl": "assets/imagesData/p4.jpg",
    "type": Data.salade,
    "cooktime":""
  },
  {
    "id": 5,
    "title": "smoothie kiwis",
    "ingredients": [
      "2 kiwis",
      "1 pomme",
      "1 yaourt nature au choix",
      "1 cas miel"
    ],
    "instructions": "mixer tous les ingrédients dans un mixeur ",
    "imageUrl": "assets/imagesData/p3.jpg",
    "type": Data.boissons,
    "cooktime":""
  },
  {
    "id": 6,
    "title": "soupe crémeuse",
    "ingredients": [
      "300 g champignons de paris",
      "10 g beurre",
      "40 g créme fraiche ",
      "1 poignée d'aneth ",
      "1 oignon",
      "1 cuillère a soupe de curry",
      "sel , poivre",
      "1 bouillon de légumes"

    ],
    "instructions": "emincez l'oignon et coupez les champignions.Faites le revenir dans le beurre.\n"
        "dans une casserole, faites bouillir de l'eau avec le bouillon de légumes,ajoutez le curry puis la créme fraiche.\n"
        "Remuez bien incorporz l'oignon et les champignions.\n"
        "salez,poivrez , parsemez d'aneth.dégustez.",
    "imageUrl": "assets/imagesData/p6.jpg",
    "type": Data.soupe,
    "cooktime":"40 min"
  },
  {
    "id": 7,
    "title": "glace a la banane",
    "ingredients": [
      "3 bananes bien mures",
      "200 ml lait ",
      "200 ml  créme liquide ",
      "50 g sucre roux (ca dépend vos gouts) "
    ],
    "instructions": "mettre les morceaux de bananes dans un mixeur et ajouter le lait,la créme et le sucre\n"
        "bien mixer le tout puis verser dans un sorbetière\n"
        "une fois la glace prise ,la verser dans un tupperware ou un récipient supportant les basses températures \n"
        "la mettre dans le congélateur au moins 15 min ou jusqu'au moment de la servir ",
    "imageUrl": "assets/imagesData/p7.jpg",
    "type": Data.glace,
    "cooktime":""
  },
  {
    "id": 8,
    "title": "patte a pizza",
    "ingredients": [
      "300 g farine",
      "pincée de sel ",
      "peu de sucre ",
      "1/2 cup d'huile d'olive",
      "1 sachet de leuvre",
      "15 cl d'eau tiéde"
    ],
    "instructions": "dans un bol verser farine,sel, ajouter huile d'olive\n"
        "diluer le sachet de leuvre dans 1/2 verre d'eau chaude, verser le tout dans le bol et pétrissez jusqu'a obtention d'une boule\n"
        "bien la fariner et couvrir d'un torchon et laissez lever pendant 30 min a 1h dans un endroit tempéré\n"
        "étalez la pate et disposez la sur du papier sulfurisé",
    "imageUrl": "assets/imagesData/p8.jpg",
    "type": Data.boulangerie,
    "cooktime":"20 min"
  },
];