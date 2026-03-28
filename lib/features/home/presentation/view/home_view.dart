import 'package:agrimind/core/widgets/app_icons.dart';
import 'package:agrimind/features/home/presentation/widgets/CustomBottomNavBar.dart';
import 'package:agrimind/features/home/presentation/widgets/header.dart';
import 'package:agrimind/features/home/presentation/widgets/live_board.dart';
import 'package:agrimind/features/home/presentation/widgets/parameters_plant.dart';
import 'package:agrimind/features/home/presentation/widgets/plant_fish_siwtch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/temperture_sensor.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isPlantSelected = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              

              Header(),
              SizedBox(height: 15),
              PlantFishSiwtch(),
              SizedBox(height: 15,),
              LiveBoard(),


              SizedBox(height: 15,),
Row(
  children: [
    ParametersPlant(description:'too cold' ,name: 'temp' ,num: 10,),
    ParametersPlant(description:'too cold' ,name: 'temp' ,num: 10,),

  ],
),
              TemperatureBarWidget(
                name: 'Temperature',
                value: 12,
                min: 0,
                max: 40,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}