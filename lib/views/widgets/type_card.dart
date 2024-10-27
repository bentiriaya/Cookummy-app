import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:get/get.dart';
import '../../Controllers/typecArdController.dart';


class TypeCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final TypeCardController controller = Get.find<TypeCardController>();

  TypeCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.selectType(title); // Met à jour le type sélectionné
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Card(
          color: controller.isTypeSelected(title) ? color.yellow : Colors.grey,
          margin: EdgeInsets.all(5.0),
          child: Container(
            width: 50,
            child: Center(
              child: Icon(
                icon.icon,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
