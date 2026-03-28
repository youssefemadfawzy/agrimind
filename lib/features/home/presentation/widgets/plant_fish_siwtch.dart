import 'package:flutter/material.dart';
import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:agrimind/features/home/presentation/widgets/Gesturdector_home_plant_fish.dart';

class PlantFishSiwtch extends StatefulWidget {
  const PlantFishSiwtch({super.key});

  @override
  State<PlantFishSiwtch> createState() => _PlantFishSiwtchState();
}

class _PlantFishSiwtchState extends State<PlantFishSiwtch> {
  bool isPlantSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 270,
      decoration: const BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// 🌱 Plant
          GesturdectorHomePlantFish(
            icon: AppIcons.planticon,
            text: 'Plant',
            isSelected: isPlantSelected,
            onTap: () {
              setState(() {
                isPlantSelected = true;
              });
            },
            activeColor: const Color(0xff00e677),
          ),

          /// 🐟 Fish
          GesturdectorHomePlantFish(
            icon: AppIcons.fishicon,
            text: 'Fish',
            isSelected: !isPlantSelected,
            onTap: () {
              setState(() {
                isPlantSelected = false;
              });
            },
            activeColor: const Color(0xff337eff),
          ),
        ],
      ),
    );
  }
}